// ===----------------------------------------------------------------------===
//
//  Injector.swift
//  CeroClient
//
//  Created by 0x41c on 2022-04-09.
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


#if canImport(foundation)
import Foundation
#endif

struct LunarProcessInfo {
    let pid: String
    let launcherVersion: String
    let version: String
    var execPath: String
    let id: String
}

enum InjectionError: Error {
    case lunarNotLaunched
    case unsupportedClientVersion
    case cannotGetTask
    case couldNotLoadBootstrap
    case machInjectFailed
}

extension InjectionError: CustomStringConvertible {
    var description: String {
        switch self {
        case .lunarNotLaunched:
            return "Lunar client is not launched!"
        case .unsupportedClientVersion:
            return "Unsupported client version."
        case .cannotGetTask:
            return "In order to inject, this must be run as root."
        case .couldNotLoadBootstrap:
            return "Unable to load embedded bootstrap: libBootstrap.dyld"
        case .machInjectFailed:
            return "Injection failed"
        }
    }
}


// I could use proc, or pid from name, but like, this is easy right?


func injector_parseProcessInfo(info: [String]) -> LunarProcessInfo {
    let info = info.filter { $0 != "" }
    let processIDX = 1
    let execPathIDX = 10
    let versionIDX = info.firstIndex(of: "--version")! + 1
    let launcherVersionIDX = info.firstIndex(of: "--launcherVersion")! + 1
    let idIDX = info.firstIndex(of: "-cp")! + 2
    
    return LunarProcessInfo(
        pid: info[processIDX],
        launcherVersion: info[launcherVersionIDX],
        version: info[versionIDX],
        execPath: info[execPathIDX],
        id: info[idIDX]
    )
}

func inject() throws {
    let processes = try utils_runCommand(command: "ps aux | grep LunarMain").components(separatedBy: "\n")
    guard processes.count > 3 else {
        throw InjectionError.lunarNotLaunched
    }
    
    let lunarInfo = injector_parseProcessInfo(info: processes.first!.components(separatedBy: " "))
    guard lunarInfo.version == "1.8" else {
        throw InjectionError.unsupportedClientVersion
    }
    
    var task: mach_port_t = 0
    guard task_for_pid(mach_task_self_, pid_t(lunarInfo.pid)!, &task) == 0 else {
        throw InjectionError.cannotGetTask
    }
    
    print("-- Beginning injection")
    
    // Move into the lunar process
    let ret: mach_error_t = RemoteExecDlopen(task, injectionPath)
    guard ret == 0 else {
        print("Ret: \(ret)")
        throw InjectionError.machInjectFailed
    }
    
    print("-- Injection complete")
}
