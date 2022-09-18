// ===----------------------------------------------------------------------===
//
//  main.swift
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

import Foundation

let fileManager = FileManager.default
let homeDirectory = fileManager.homeDirectoryForCurrentUser.path
let ceroHome = "\(homeDirectory)/.ceroclient"
let assetDirectory = "./assets"
let injectedDylibFile = "libBootstrap.dylib"
let injectionPath = "\(ceroHome)/\(injectedDylibFile)"

enum LauncherError: Error {
    case assetsNotFound
    case machServiceFailed
}

extension LauncherError: CustomStringConvertible {
    var description: String {
        switch self {
        case .assetsNotFound:
            return "Could not find assets directory or contained assets. Did you delete them!?"
        case .machServiceFailed:
            return "The helper service failed to be active"
        }
    }
}

fileprivate func _runCommand(_ command: String) throws {
    _ = try utils_runCommand(command: command)
}

fileprivate func _selfDestruct() throws {
#if DEBUG
    try _runCommand("rm -rf ~/.ceroclient")
#endif
}

fileprivate func ensureHomeDirectory() throws {
    if !fileManager.fileExists(atPath: ceroHome) {
        let paths = [
            assetDirectory,
            "\(assetDirectory)/\(injectedDylibFile)"
        ]
        for path in paths {
            guard fileManager.fileExists(atPath: path) else {
                throw LauncherError.assetsNotFound
            }
        }
        
        try _runCommand("cp -rf \(assetDirectory) \(ceroHome)")
    } else {
        try _runCommand("rm -rf \(ceroHome)")
        try ensureHomeDirectory()
    }
}

do {
    try ensureHomeDirectory()
    try inject()
    RunLoop.main.run()
} catch {
    print("[ERROR] \(error)")
    exit(1)
}
