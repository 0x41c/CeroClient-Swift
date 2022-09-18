// ===----------------------------------------------------------------------===
//
//  CeroClient.swift
//  Bootstrap
//
//  Created by 0x41c on 2022-04-15.
//
// ===----------------------------------------------------------------------===
//
//  Copyright 2022 0x41c
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
// ===----------------------------------------------------------------------===


import Foundation

typealias GetCreatedVMs_t = @convention(c) (
    UnsafeMutablePointer<UnsafeMutablePointer<JavaVM?>>,
    JavaInt,
    UnsafeMutablePointer<JavaInt>
) -> JavaInt

class CeroClient {
    
    private var gcvmsPtr: UnsafeMutableRawPointer?
    private var _classLoader: JavaClassWrapper? = nil
    
    var GetCreatedVMs: GetCreatedVMs_t
    var vm: JavaVM
    var jni: JNI
    var shouldRun: Bool = true
    
    static var main: CeroClient = { CeroClient() }()
    
    var classLoader: JavaClassWrapper {
        if _classLoader == nil  {
            let threadGroup: JavaClassWrapper = JavaClassWrapper(fromClass: "java.lang.Thread", true)
                .method("currentThread", "()Ljava/lang/Thread;")
                .method("getThreadGroup", "()Ljava/lang/ThreadGroup;")
            let threadArray = jni.newArray(threadGroup.field("nthreads", "I"), .object, jni.findClass("java.lang.Thread"))
            let _: Void = threadGroup.method("enumerate", "([Ljava/lang/Thread;)I", JavaValue(object: threadArray))
            _classLoader = jni.getObjectArrayElement(threadArray, 0).method("getContextClassLoader", "()Ljava/lang/ClassLoader;")
        }
        return _classLoader!
    }
    
    init() {
        
        let handle = dlopen(nil, RTLD_LAZY)
        let cjvs = dlsym(handle, "JNI_GetCreatedJavaVMs")
        var _vm: JavaVM?
        var _vmWrapper = withUnsafeMutablePointer(to: &_vm) { $0 }
        var size: JavaInt = 0
        
        gcvmsPtr = cjvs
        GetCreatedVMs = unsafeBitCast(cjvs, to: GetCreatedVMs_t.self)
        
        var ret = GetCreatedVMs(&_vmWrapper, 1, &size)
        
        guard ret == JNI_OK, _vmWrapper.pointee != nil else {
            error("Could not get JavaVM: JNI_GetCreatedJavaVMs failed with ret (\(ret))")
        }
        
        vm = _vmWrapper.pointee!
        
        var _unused: UnsafeMutablePointer<JNIEnv>? = nil
        ret = vm.pointee.AttachCurrentThread(&vm, &_unused, nil)
        
        guard ret == JNI_OK, _unused != nil else {
            error("Could not Attach: AttachCurrentThread failed with ret (\(ret))")
        }
        
        var _envWrapperPointer: UnsafeMutableRawPointer? = nil
        ret = vm.pointee.GetEnv(&vm, &_envWrapperPointer, JNI_VERSION_1_6)
        
        guard ret == JNI_OK, _envWrapperPointer != nil else {
            error("Could not get JNIEnv: GetEnv failed with ret (\(ret))")
        }
        
        jni = JNI(pointer: _envWrapperPointer!.bindMemory(to: JNIEnv.self, capacity: 1))
        
        // TODO: Implement swift/java type conversion both ways dynamically
    }
    
    func begin() {
        canLogToClient = true
        
        log("\(self)")
        
        log("--Entering Run Loop--")
        log("Display: \(jni.findClass("org.lwjgl.opengl.Display"))")
        log("Name: \(Minecraft.main.serverName)")
        
        var wasInGame = false
        while shouldRun {
            if Minecraft.main.inGame {
                if !wasInGame {
                    wasInGame.toggle()
                    log("Joined server")
                }
            } else {
                if wasInGame {
                    wasInGame.toggle()
                    log("Left server!")
                }
            }
            Thread.sleep(forTimeInterval: 0.005)
        }
    }
    
    func findClass(_ className: String) -> JavaClassWrapper {
        return classLoader.method(
            "loadClass",
            "(Ljava/lang/String;)Ljava/lang/Class;",
            JavaValue(
                object: jni.newUTFString(className)
            )
        )
    }
    
    func findClassOptional(_ className: String) -> JavaObject? {
        let method = jni.getMethodID(classLoader.object, "loadClass", "(Ljava/lang/String;)Ljava/lang/Class;")
        var val = JavaValue(object: jni.newUTFString(className))
        return jni.pointer.pointee.pointee.CallObjectMethod(jni.pointer, classLoader.object, method, &val)
    }
    
}

extension CeroClient: CustomStringConvertible {
    var description: String {
        return """
        CeroClient(
            GetCreatedVMs: \(gcvmsPtr!)
            JavaVM: \(vm)
            Env: \(jni.pointer)
            ClassLoader: \(classLoader)
        )
        """
    }
}

// See, I even gave you a base, do your job and fix the TODO.

extension CeroClient {
    enum MainError: Error {
        case couldNotGet(String, String?)
    }
}

extension CeroClient.MainError: CustomStringConvertible {
    var description: String {
        switch self {
        case .couldNotGet(let thing, let reason):
            return "Could not get \(thing) \(reason != nil ? ": \(reason!)" : "")"
        }
    }
}
