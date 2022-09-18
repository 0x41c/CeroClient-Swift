// ===----------------------------------------------------------------------===
//
//  Methods.swift
//  Bootstrap
//
//  Created by 0x41c on 2022-04-18.
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


// TODO: Move this whole file into a gyb to satisfy the DRY rule

import Foundation

enum MethodIDType {
    case regular
    case `static`
}

extension JNI {
    
    func getMethodID(
        _ jclass: JavaClass,
        _ methodName: String,
        _ methodSignature: String,
        _ methodType: MethodIDType = .regular,
        _ isClazz: Bool = false
    ) -> JavaMethodID {
        var ret: JavaMethodID? = nil
        
        if methodType == .static {
            ret = pointer.pointee.pointee.GetStaticMethodID(
                pointer,
                jclass,
                methodName,
                methodSignature
            )
        } else {
            ret = pointer.pointee.pointee.GetMethodID(
                pointer,
                isClazz ? jclass : getObjectClass(jclass),
                methodName,
                methodSignature
            )
        }
        
        guard ret != nil else {
            error("\(methodType == .static ? "Static class" : "Class") \(jclass) did not have method \"\(methodName)\", or the signature \"\(methodSignature)\" was invalid.")
        }
        
        return ret!
    }
    
}

fileprivate extension JNI {
    
    func _methodFail(_ name: String) -> Never {
        error("Expected a return value from method \"\(name)\" but got nil.")
    }
    
}

// Static
extension JNI {
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.CallStaticObjectMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaBoolean {
        let ret: JavaBoolean? = pointer.pointee.pointee.CallStaticBooleanMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaByte {
        let ret: JavaByte? = pointer.pointee.pointee.CallStaticByteMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaChar {
        let ret: JavaChar? = pointer.pointee.pointee.CallStaticCharMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaShort {
        let ret: JavaShort? = pointer.pointee.pointee.CallStaticShortMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaInt {
        let ret: JavaInt? = pointer.pointee.pointee.CallStaticIntMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaLong {
        let ret: JavaLong? = pointer.pointee.pointee.CallStaticLongMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaFloat {
        let ret: JavaFloat? = pointer.pointee.pointee.CallStaticFloatMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaDouble {
        let ret: JavaDouble? = pointer.pointee.pointee.CallStaticDoubleMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callStaticMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) {
        _ = pointer.pointee.pointee.CallStaticVoidMethodA(
            pointer,
            jclass,
            methodID,
            parameters
        )
    }
    
}

// Dynamic
extension JNI {
    
    // Call
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.CallObjectMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaBoolean {
        let ret: JavaBoolean? = pointer.pointee.pointee.CallBooleanMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaByte {
        let ret: JavaByte? = pointer.pointee.pointee.CallByteMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaChar {
        let ret: JavaChar? = pointer.pointee.pointee.CallCharMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaShort {
        let ret: JavaShort? = pointer.pointee.pointee.CallShortMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaInt {
        let ret: JavaInt? = pointer.pointee.pointee.CallIntMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaLong {
        let ret: JavaLong? = pointer.pointee.pointee.CallLongMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaFloat {
        let ret: JavaFloat? = pointer.pointee.pointee.CallFloatMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    ) -> JavaDouble {
        let ret: JavaDouble? = pointer.pointee.pointee.CallDoubleMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
        
        guard ret != nil else {
            _methodFail(methodName)
        }
        
        return ret!
    }
    
    func callMethod(
        _ jclass: JavaClass,
        _ methodID: JavaMethodID,
        _ parameters: UnsafePointer<JavaValue>,
        _ methodName: String = "NO NAME"
    )  {
        pointer.pointee.pointee.CallVoidMethod(
            pointer,
            jclass,
            methodID,
            parameters
        )
    }
}
