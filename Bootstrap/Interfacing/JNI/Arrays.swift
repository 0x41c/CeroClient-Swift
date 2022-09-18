// ===----------------------------------------------------------------------===
//
//  Arrays.swift
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
    
    fileprivate func _arrayFail(_ array: JavaArray) -> Never {
        error("Could not get array elements of array: \(array)")
    }
    
}

extension JNI {
    
    func newArray(
        _ size: JavaInt,
        _ type: JavaType,
        _ jclass: JavaClass? = nil,
        _ initialObject: JavaObject? = nil
    ) -> JavaArray {
        
        var ret: JavaArray? = nil
        
        switch type {
        case .bool:
            ret = pointer.pointee.pointee.NewBooleanArray(
                pointer,
                size
            )
            break
        case .byte:
            ret = pointer.pointee.pointee.NewByteArray(
                pointer,
                size
            )
            break
        case .char:
            ret = pointer.pointee.pointee.NewCharArray(
                pointer,
                size
            )
            break
        case .short:
            ret = pointer.pointee.pointee.NewShortArray(
                pointer,
                size
            )
            break
        case .int:
            ret = pointer.pointee.pointee.NewIntArray(
                pointer,
                size
            )
            break
        case .long:
            ret = pointer.pointee.pointee.NewLongArray(
                pointer,
                size
            )
            break
        case .float:
            ret = pointer.pointee.pointee.NewFloatArray(
                pointer,
                size
            )
            break
        case .double:
            ret = pointer.pointee.pointee.NewDoubleArray(
                pointer,
                size
            )
            break
        case .object:
            guard jclass != nil else {
                error("Tried creating object array without specifying a class")
            }
            ret = pointer.pointee.pointee.NewObjectArray(
                pointer,
                size,
                jclass,
                initialObject
            )
            break
        }
        
        guard ret != nil else {
            error("Could not create new array with size: \(size)")
        }
        
        return ret!
    }
    
    func getArrayLength(
        _ array: JavaArray
    ) -> JavaInt {
        pointer.pointee.pointee.GetArrayLength(
            pointer,
            array
        )
    }
    
    func getObjectArrayElement(
        _ array: JavaObjectArray,
        _ index: JavaInt
    ) -> JavaObject {
        let ret: JavaObject? = pointer.pointee.pointee.GetObjectArrayElement(
            pointer,
            array,
            index
        )
        
        guard ret != nil else {
            error("Could not get object array element at index: \(index)")
        }
        
        return ret!
    }
    
    func getObjectArrayElement(
        _ array: JavaObjectArray,
        _ index: JavaInt,
        _ _type: JavaObjectClassType = .initialized
    ) -> JavaClassWrapper {
        let ret: JavaClass? = pointer.pointee.pointee.GetObjectArrayElement(
            pointer,
            array,
            index
        )
        
        guard ret != nil else {
            error("Could not get object array element at index: \(index)")
        }
        
        return JavaClassWrapper(from: ret!, type: _type, scope: .local)
    }
    
    func getArrayElements(
        _ array: JavaBooleanArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaBoolean> {
        let ret: UnsafeMutablePointer<JavaBoolean>? = pointer.pointee.pointee.GetBooleanArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaByteArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaByte> {
        let ret: UnsafeMutablePointer<JavaByte>? = pointer.pointee.pointee.GetByteArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaCharArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaChar> {
        let ret: UnsafeMutablePointer<JavaChar>? = pointer.pointee.pointee.GetCharArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaShortArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaShort> {
        let ret: UnsafeMutablePointer<JavaShort>? = pointer.pointee.pointee.GetShortArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaIntArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaInt> {
        let ret: UnsafeMutablePointer<JavaInt>? = pointer.pointee.pointee.GetIntArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaLongArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaLong> {
        let ret: UnsafeMutablePointer<JavaLong>? = pointer.pointee.pointee.GetLongArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaFloatArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaFloat> {
        let ret: UnsafeMutablePointer<JavaFloat>? = pointer.pointee.pointee.GetFloatArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
    func getArrayElements(
        _ array: JavaDoubleArray,
        _ isCopy: inout JavaBoolean
    ) -> UnsafeMutableBufferPointer<JavaDouble> {
        let ret: UnsafeMutablePointer<JavaDouble>? = pointer.pointee.pointee.GetDoubleArrayElements(
            pointer,
            array,
            &isCopy
        )
        
        guard ret != nil else {
            _arrayFail(array)
        }
        
        let bufferLength = getArrayLength(array)
        return UnsafeMutableBufferPointer(start: ret!, count: Int(bufferLength))
    }
    
}
