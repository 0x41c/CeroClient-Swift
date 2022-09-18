// ===----------------------------------------------------------------------===
//
//  Strings.swift
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

    func newString(
        _ string: String
    ) -> JavaString {
        let ret: JavaString? = pointer.pointee.pointee.NewString(
            pointer,
            string.rawJavaString,
            jsize(string.count)
        )
        
        guard ret != nil else {
            error("Could not create a new string with prefix \"\(string.prefix(10))\"")
        }
        
        return ret!
    }
    
    func newUTFString(
        _ string: String
    ) -> JavaString {
        let ret: JavaString? = pointer.pointee.pointee.NewStringUTF(
            pointer,
            string
        )
        
        guard ret != nil else {
            error("Could not create a new string with prefix \"\(string.prefix(10))\"")
        }
        
        return ret!
    }
    
    func stringLength(
        _ string: JavaString
    ) -> JavaInt {
        pointer.pointee.pointee.GetStringLength(
            pointer,
            string
        )
    }
    
    func utfStringLength(
        _ string: JavaString
    ) -> JavaInt {
        pointer.pointee.pointee.GetStringUTFLength(
            pointer,
            string
        )
    }
    
    func stringChars(
        _ string: JavaString,
        _ isCopy: UnsafeMutablePointer<JavaBoolean>?
    ) -> UnsafePointer<JavaChar> {
        let ret: UnsafePointer<JavaChar>? = pointer.pointee.pointee.GetStringChars(
            pointer,
            string,
            isCopy
        )
        
        guard ret != nil else {
            error("Could not get string charectors from string: \(string)")
        }
        
        return ret!
    }
    
    func utfStringChars(
        _ string: JavaString,
        _ isCopy: UnsafeMutablePointer<JavaBoolean>?
    ) -> UnsafePointer<CChar> {
        let ret: UnsafePointer<CChar>? = pointer.pointee.pointee.GetStringUTFChars(
            pointer,
            string,
            isCopy
        )
        
        guard ret != nil else {
            error("Could not get string charectors from string: \(string)")
        }
        
        return ret!
    }
    
    
}


extension JavaString {
    
    var string: String {
        CeroClient.main.jni.utfStringChars(self, nil).string
    }
    
}
