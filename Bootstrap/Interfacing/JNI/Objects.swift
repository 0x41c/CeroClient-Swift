// ===----------------------------------------------------------------------===
//
//  Objects.swift
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
    
    func isSameObject(
        _ a: JavaObject,
        _ b: JavaObject
    ) -> JavaBoolean {
        pointer.pointee.pointee.IsSameObject(
            pointer,
            a,
            b
        )
    }
    
    func allocateObject(
        _ jclass: JavaClass
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.AllocObject(
            pointer,
            jclass
        )
        
        guard ret != nil else {
            error("Could not allocate object with class \(jclass)")
        }
        
        return ret!
    }
    
    func newObject(
        _ jclass: JavaClass,
        _ constructorMethodID: JavaMethodID,
        _ constructorArguments: UnsafePointer<JavaValue>
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.NewObject(
            pointer,
            jclass,
            constructorMethodID,
            constructorArguments
        )
        
        guard ret != nil else {
            error("Could not create new object \(jclass)")
        }
        
        return ret!
    }
    
    func getObjectClass(
        _ jobject: JavaObject
    ) -> JavaClass {
        let ret: JavaClass? = pointer.pointee.pointee.GetObjectClass(
            pointer,
            jobject
        )
        
        guard ret != nil else {
            error("Could not get object class")
        }
        
        return ret!
    }
    
    func isObject(
        _ object: JavaObject,
        instanceOf jclass: JavaClass
    ) -> JavaBoolean {
        pointer.pointee.pointee.IsInstanceOf(
            pointer,
            object,
            jclass
        )
    }
    
}
