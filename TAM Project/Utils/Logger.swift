//
//  Logger.swift
//  TAM Project
//
//  Created by digital on 15/03/2024.
//

import Foundation

protocol LogProtocol {
    static func log(_ message: String) -> Void
}

class Logger: LogProtocol {
    public static func log(_ message: String) -> Void {
        #if DEBUG
            print("## Logger : Common - \(message)")
        #endif
    }
}

class KeyboardLogger: LogProtocol {
    public static func log(_ message: String) -> Void {
        #if DEBUG
            print("## Logger : Keyboard - \(message)")
        #endif
    }
}

class ErrorLogger: LogProtocol {
    public static func log(_ message: String) -> Void {
        #if DEBUG
            print("## Logger : Error - \(message)")
        #endif
    }
}
