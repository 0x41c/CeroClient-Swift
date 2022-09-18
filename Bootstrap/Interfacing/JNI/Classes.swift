// ===----------------------------------------------------------------------===
//
//  Classes.swift
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


import Foundation

extension JNI {
    
    func findClass(_ name: String, _ replace: Bool = true) -> JavaClass {
        let ret: JavaClass? = pointer.pointee.pointee.FindClass(
            pointer,
            replace ? name.replacingOccurrences(of: ".", with: "/") : name
        )
        
        guard ret != nil else {
            error("Could not find class \"\(name)\"")
        }
        
        return ret!
    }
    
    func defineClass(
        _ name: String,
        _ loader: JavaClass,
        _ buffer: UnsafePointer<JavaByte>,
        _ bufferLength: JavaInt
    ) -> JavaClass {
        let ret: JavaClass? = pointer.pointee.pointee.DefineClass(
            pointer,
            name,
            loader,
            buffer,
            bufferLength
        )
        
        guard ret != nil else {
            error("Could not define class \"\(name)\"")
        }
        
        return ret!
    }
    
    func getSuperClass(
        _ fromClass: JavaClass
    ) -> JavaClass {
        let ret: JavaClass? = pointer.pointee.pointee.GetSuperclass(
            pointer,
            fromClass
        )
        
        guard ret != nil else {
            error("Could not get superclass of class: \(fromClass)")
        }
        
        return ret!
    }
    
    func canCast(
        from class1: JavaClass,
        to class2: JavaClass
    ) -> JavaBoolean {
        pointer.pointee.pointee.IsAssignableFrom(
            pointer,
            class1,
            class2
        )
    }
    
}
