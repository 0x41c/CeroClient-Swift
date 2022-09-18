// ===----------------------------------------------------------------------===
//
//  Minecraft.swift
//  Bootstrap
//
//  Created by 0x41c on 2022-04-20.
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


class Minecraft: JavaClassWrapper {
    
    static var `static`: JavaClassWrapper {
        CeroClient.main.findClass(Mappings.MinecraftClient.rawValue).clazz
    }
    
    static var main: Minecraft = {
        Minecraft(fromClass: Mappings.MinecraftClient.rawValue)
    }()
    
    static var logger: MCLogger = { MCLogger() }()
    
    var inGame: Bool {
        let _world = client.findClassOptional(Mappings.World.rawValue)
        let _player = client.findClassOptional(Mappings.Player.rawValue)
        return _world != nil && _player != nil
    }
    
    var player: Player {
        
        guard inGame else {
            error("Tried to access player object while not in game")
        }
        
        return Player()
        
    }
    
    var world: World {
        
        guard inGame else {
            error("Tried to access world object while not in game")
        }
        
        return World()
    }
    
    var serverName: String {
        field("aq", "java.lang.String").string
    }
    
}
