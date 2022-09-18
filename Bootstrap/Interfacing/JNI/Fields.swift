// ===----------------------------------------------------------------------===
//
//  Fields.swift
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

typealias FieldIDType = MethodIDType

fileprivate extension JNI {
    
    func _failField(_ name: String) -> Never {
        error("Could not get field \"\(name)\"")
    }
    
}

extension JNI {
    
    func getFieldID(
        _ jclass: JavaClass,
        _ fieldName: String,
        _ fieldTypeSignature: String,
        _ type: FieldIDType
    ) -> JavaFieldID {
        var ret: JavaFieldID? = nil
        if type == .static {
            ret = pointer.pointee.pointee.GetStaticFieldID(
                pointer,
                jclass,
                fieldName,
                fieldTypeSignature
            )
        } else {
            let clazz: JavaClass = getObjectClass(jclass)
            ret = pointer.pointee.pointee.GetFieldID(
                pointer,
                clazz,
                fieldName,
                fieldTypeSignature
            )
        }

        guard ret != nil else {
            error("Class \(jclass) did not have field \"\(fieldName)\", or the signature \"\(fieldTypeSignature)\" was invalid.")
        }
        
        return ret!
    }
}

// Static
extension JNI {
    
    // MARK: - Static Field Getters
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.GetStaticObjectField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaBoolean {
        let ret: JavaBoolean? = pointer.pointee.pointee.GetStaticBooleanField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaByte {
        let ret: JavaByte? = pointer.pointee.pointee.GetStaticByteField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaChar {
        let ret: JavaChar? = pointer.pointee.pointee.GetStaticCharField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaShort {
        let ret: JavaShort? = pointer.pointee.pointee.GetStaticShortField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaInt {
        let ret: JavaInt? = pointer.pointee.pointee.GetStaticIntField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaLong {
        let ret: JavaLong? = pointer.pointee.pointee.GetStaticLongField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaFloat {
        let ret: JavaFloat? = pointer.pointee.pointee.GetStaticFloatField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaDouble {
        let ret: JavaDouble? = pointer.pointee.pointee.GetStaticDoubleField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    // MARK: - Static Field Setters
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jobject: JavaObject
    ) {
        pointer.pointee.pointee.SetStaticObjectField(
            pointer,
            jclass,
            fieldID,
            jobject
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jbool: JavaBoolean
    ) {
        pointer.pointee.pointee.SetStaticBooleanField(
            pointer,
            jclass,
            fieldID,
            jbool
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jbyte: JavaByte
    ) {
        pointer.pointee.pointee.SetStaticByteField(
            pointer,
            jclass,
            fieldID,
            jbyte
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jchar: JavaChar
    ) {
        pointer.pointee.pointee.SetStaticCharField(
            pointer,
            jclass,
            fieldID,
            jchar
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jshort: JavaShort
    ) {
        pointer.pointee.pointee.SetStaticShortField(
            pointer,
            jclass,
            fieldID,
            jshort
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jint: JavaInt
    ) {
        pointer.pointee.pointee.SetStaticIntField(
            pointer,
            jclass,
            fieldID,
            jint
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jlong: JavaLong
    ) {
        pointer.pointee.pointee.SetStaticLongField(
            pointer,
            jclass,
            fieldID,
            jlong
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jfloat: JavaFloat
    ) {
        pointer.pointee.pointee.SetStaticFloatField(
            pointer,
            jclass,
            fieldID,
            jfloat
        )
    }
    
    func setStaticField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jdouble: JavaDouble
    ) {
        pointer.pointee.pointee.SetStaticDoubleField(
            pointer,
            jclass,
            fieldID,
            jdouble
        )
    }
}

extension JNI {
    
    // MARK: - Field Getters
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.GetObjectField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaBoolean {
        let ret: JavaBoolean? = pointer.pointee.pointee.GetBooleanField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaByte {
        let ret: JavaByte? = pointer.pointee.pointee.GetByteField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaChar {
        let ret: JavaChar? = pointer.pointee.pointee.GetCharField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaShort {
        let ret: JavaShort? = pointer.pointee.pointee.GetShortField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaInt {
        let ret: JavaInt? = pointer.pointee.pointee.GetIntField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaLong {
        let ret: JavaLong? = pointer.pointee.pointee.GetLongField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaFloat {
        let ret: JavaFloat? = pointer.pointee.pointee.GetFloatField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    func getField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ fieldName: String = "NO NAME"
    ) -> JavaDouble {
        let ret: JavaDouble? = pointer.pointee.pointee.GetDoubleField(
            pointer,
            jclass,
            fieldID
        )
        
        guard ret != nil else {
            _failField(fieldName)
        }
        
        return ret!
    }
    
    // MARK: - Field Setters
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jobject: JavaObject
    ) {
        pointer.pointee.pointee.SetObjectField(
            pointer,
            jclass,
            fieldID,
            jobject
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jbool: JavaBoolean
    ) {
        pointer.pointee.pointee.SetBooleanField(
            pointer,
            jclass,
            fieldID,
            jbool
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jbyte: JavaByte
    ) {
        pointer.pointee.pointee.SetByteField(
            pointer,
            jclass,
            fieldID,
            jbyte
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jchar: JavaChar
    ) {
        pointer.pointee.pointee.SetCharField(
            pointer,
            jclass,
            fieldID,
            jchar
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jshort: JavaShort
    ) {
        pointer.pointee.pointee.SetShortField(
            pointer,
            jclass,
            fieldID,
            jshort
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jint: JavaInt
    ) {
        pointer.pointee.pointee.SetIntField(
            pointer,
            jclass,
            fieldID,
            jint
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jlong: JavaLong
    ) {
        pointer.pointee.pointee.SetLongField(
            pointer,
            jclass,
            fieldID,
            jlong
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jfloat: JavaFloat
    ) {
        pointer.pointee.pointee.SetFloatField(
            pointer,
            jclass,
            fieldID,
            jfloat
        )
    }
    
    func setField(
        _ jclass: JavaClass,
        _ fieldID: JavaFieldID,
        _ jdouble: JavaDouble
    ) {
        pointer.pointee.pointee.SetDoubleField(
            pointer,
            jclass,
            fieldID,
            jdouble
        )
    }
}
