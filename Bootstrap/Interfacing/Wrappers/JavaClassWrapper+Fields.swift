// ===----------------------------------------------------------------------===
//
//  JavaClassWrapper+Fields.swift
//  Bootstrap
//
//  Created by 0x41c on 2022-04-19.
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

typealias JavaFieldType = JavaMethodReturnType

extension JavaClassWrapper {
    
    private func _fieldValue(
        _ name: String,
        _ _type: String,
        _ fieldType: JavaFieldType
    ) -> JavaFieldID {
        let field: JavaFieldID = client.jni.getFieldID(
            object,
            name,
            _type,
            classType == .static ? .static : .regular
        )
        
        let returningClass = _type.contains("L") && ![
            "Z", "B", "C", "S", "I", "J", "F", "D"
        ].contains(_type.replacingOccurrences(of: "[", with: ""))
        
        guard fieldType == .referenceType ? returningClass : !returningClass else {
            error("Tried to get type from field that returns different reference type.")
        }
        
        return field
    }
    
    
    func field(_ name: String,_ _type: String) -> JavaObject {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .referenceType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaBoolean {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaByte {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaChar {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaShort {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaInt {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaLong {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaDouble {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
    
    func field(_ name: String,_ _type: String) -> JavaFloat {
        _guardUse("field") {
            let value = _fieldValue(name, _type, .valueType)
            if classType == .static { return client.jni.getStaticField(object, value) }
            return client.jni.getField(object, value)
        }
    }
}
