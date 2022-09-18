// ===----------------------------------------------------------------------===
//
//  References.swift
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

//      void (* _Nonnull ReleaseStringChars)(JNIEnv * _Nonnull, jstring, const jchar * _Nonnull);
//      void (* _Nonnull ReleaseStringUTFChars)(JNIEnv * _Nonnull, jstring, const char * _Nullable);

extension JNI {
    
    func deleteLocalRef(
        _ jobject: JavaObject
    ) {
        pointer.pointee.pointee.DeleteLocalRef(pointer, jobject)
    }
    
    func deleteGlobalRef(
        _ jobject: JavaObject
    ) {
        pointer.pointee.pointee.DeleteGlobalRef(pointer, jobject)
    }
    
    func cleanUpTrackedObjects() {
        for trackedObject in trackedObjects {
            let scope = trackedObject.keys.first!
            if scope == .local {
                deleteLocalRef(trackedObject[.local]!)
            } else {
                deleteGlobalRef(trackedObject[.global]!)
            }
        }
    }
    
}
