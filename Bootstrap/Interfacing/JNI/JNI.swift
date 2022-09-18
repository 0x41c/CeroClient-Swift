// ===----------------------------------------------------------------------===
//
//  JNI.swift
//  Bootstrap
//
//  Created by 0x41c on 2022-04-16.
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

// TODO: Make every function available to swift safe and available to use from this wrapper
// TODO: Create a class/name map to track the names of classes for debugging use
// TODO: Make use of JavaObjectRefType instead of JavaObjectReferenceScope

struct JNI {
    
    var trackedObjects = [[JavaObjectReferenceScope : JavaObject]]()
    var pointer: UnsafeMutablePointer<JNIEnv>
    
    var version: Double {
        let _version: JavaInt = pointer.pointee.pointee.GetVersion(pointer)
        let l = (_version & 0xF0000) >> 16
        let r = (_version & 0xF)
        return Double("\(l).\(r)")!
    }

}

extension JNI: CustomStringConvertible {
    var description: String {
        "\(pointer)"
    }
}

// Util

enum JavaType {
    case bool
    case byte
    case char
    case short
    case int
    case long
    case float
    case double
    case object
}
