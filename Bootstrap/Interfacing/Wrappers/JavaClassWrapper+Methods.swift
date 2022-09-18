// ===----------------------------------------------------------------------===
//
//  JavaClassWrapper+Methods.swift
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

enum JavaMethodReturnType {
    case referenceType
    case valueType
}

struct JavaMethodValue {
    let arguments: UnsafePointer<JavaValue>
    let methodID: JavaMethodID
}

extension JavaClassWrapper {
    
    
    fileprivate func _methodValue(
        _ name: String,
        _ signature: String,
        _ retType: JavaMethodReturnType,
        _ args: [JavaValue]
    ) -> JavaMethodValue {
        let method = client.jni.getMethodID(
            object,
            name,
            signature,
            classType == .static ? .static : .regular
        )
        
        let returnType = String(signature.split(separator: ")").last!)
        let returningInstance = returnType.contains("L") && ![
            "Z", "B", "C", "S", "I", "J", "F", "D"
        ].contains(returnType.replacingOccurrences(of: "[", with: ""))
        
        guard retType == .referenceType ? returningInstance : !returningInstance else {
            error("Tried to get type from method that returns different reference type.")
        }
        
        return JavaMethodValue(
            arguments: args.withUnsafeBufferPointer({ ptr in
                ptr.baseAddress!
            }),
            methodID: method
        )
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaClassWrapper {
        _guardUse("method") {
            let value = _methodValue(name, signature, .referenceType, args)
            return JavaClassWrapper(from: client.jni.callMethod(object, value.methodID, value.arguments, name), type: .initialized, scope: .local)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaObject {
        _guardUse("method") {
            let value = _methodValue(name, signature, .referenceType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaBoolean {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaByte {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaChar {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaShort {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaInt {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaLong {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaDouble {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) -> JavaFloat {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            return client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
    func method(_ name: String,_ signature: String, _ args: JavaValue...) {
        _guardUse("method") {
            let value = _methodValue(name, signature, .valueType, args)
            let _: Void = client.jni.callMethod(object, value.methodID, value.arguments, name)
        }
    }
    
}
