// ===----------------------------------------------------------------------===
//
//  JavaClassWrapper.swift
//  Bootstrap
//
//  Created by 0x41c on 2022-04-17.
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

class JavaClassWrapper {
    
    private let _object: JavaClass?
    private var _clazz: JavaClassWrapper?
    
    let client: CeroClient = CeroClient.main
    let scope: JavaObjectReferenceScope
    let classType: JavaObjectClassType

    var object: JavaClass {
        _guardUse("object") {
            _object!
        }
    }
    
    var clazz: JavaClassWrapper {
        if _clazz == nil {
            _clazz = JavaClassWrapper(
                from:  _guardUse("clazz") { client.jni.getObjectClass(object) },
                type: .static,
                scope: .local
            )
        }
        return _clazz!
    }
    
    init(
        fromClass name: String,
        _ clazz: Bool = false
    ) {
        
        scope = .local
        
        if !clazz {
            _object = client.findClass(name).object
            classType = .initialized
        } else {
            let name = name.replacingOccurrences(of: ".", with: "/")
            _object = client.jni.findClass(name)
            classType = .static
        }
        
        _trackSelf()
    }
    
    init(
        from _object: JavaClass,
        type _classType: JavaObjectClassType,
        scope _scope: JavaObjectReferenceScope
    ) {
        self._object = _object
        self.scope = _scope
        self.classType = _classType
        _trackSelf()
    }
    
    func _trackSelf() {
        CeroClient.main.jni.trackedObjects.append([scope: object])
    }
    
    func _guardUse<T>(_ _name: String, _ body: () -> T) -> T {
        guard _object != nil else {
            error("[\(_name)] Cannot access java class after it has been deleted from \(scope == .global ? "global" : "local") scope")
        }
        return body()
    }
    
    deinit {
        client.jni.trackedObjects.removeAll { $0.first!.value == object }
        switch scope {
        case .local:
            client.jni.deleteLocalRef(object)
        case .global:
            client.jni.deleteGlobalRef(object)
        }
    }
}

enum JavaObjectReferenceScope {
    case local
    case global
}

enum JavaObjectClassType {
    case `static`
    case `initialized`
}

extension JavaClassWrapper: CustomStringConvertible {
    var description: String {
        "\(object)"
    }
}
