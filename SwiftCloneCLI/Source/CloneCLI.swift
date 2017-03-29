//
//  CloneCLI.swift
//  SwiftCloneCLI
//
//  Created by Vignesh on 28/03/17.
//  Copyright © 2017 vigneshuvi. All rights reserved.
//

import Foundation


@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = SystemCommands.bash.rawValue
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func shell(_ args: String..., path: String) -> Int32 {
    let task = Process()
    task.launchPath = SystemCommands.bash.rawValue
    task.arguments = args
    task.currentDirectoryPath = path
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func shell(_ launchPath: String, comments:String...) -> Int32 {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = comments
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func shellwithoptions(_ launchPath: String, comments:[String], path: String) -> Int32 {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = comments
    task.currentDirectoryPath = path
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

//MARK: -  Enumaration for steps
public enum CloneSteps:NSInteger {
    case GetApplicationName
    case GetBitBucketUserName
    case GetBitBucketPassword
    case GetBitBucketRepo
    case GetBitBucketCheckoutPath
    case StartProcess
    case quit = -1
}

//MARK: -  Enumaration for system Commands
public enum SystemCommands:String {
    case bash = "/usr/bin/env"
    case git = "/usr/bin/git"
}

//MARK: -  Struct for Color Log
struct ColorLog {
    
    static let ESCAPE = "\u{001B}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + "0m"   // Clear any foreground or background color
    
    static func red<T>(object: T) {
        print("\(ESCAPE)31m\(object)\(RESET)")
    }
    
    static func green<T>(object: T) {
        print("\(ESCAPE)32m\(object)\(RESET)")
    }
    
    static func blue<T>(object: T) {
        print("\(ESCAPE)34m\(object)\(RESET)")
    }
    
    static func yellow<T>(object: T) {
        print("\(ESCAPE)33m\(object)\(RESET)")
    }
    
    static func purple<T>(object: T) {
        print("\(ESCAPE)35m\(object)\(RESET)")
    }
    
}

//MARK: -  Enumaration for log type
public enum LogType {
    case Info
    case Verbose
    case Warnings
    case Debug
    case Error
}

//MARK: -  CloneCLI Class
open class CloneCLI {
    
    // The Application name.
    var applicatonName:String = "";
    
    // The Application checkout path.
    var applicatonCheckOutPathName:String = CloneCLI.defaultCheckoutDirectory();
    
    // The BitBucket  Username.
    var bitBucketUsername:String = "";
    
    // The BitBucket Password.
    var bitBucketPassword:String = "";
    
    // The BitBucket URL.
    var bitBucketURL:String = "";
    
    // The BitBucket repo name.
    var bitBucketRepoName:String = "";
    
    // CloneCLI singleton
    open class var cloneCLI: CloneCLI {
        
        struct Static {
            static let instance: CloneCLI = CloneCLI()
        }
        return Static.instance
    }
    
    // Set Application name
    func setApplicationName(_ appname: String){
        applicatonName = appname;
        printLog(LogType.Debug, text:"\nWelcome to \(appname) application!!!")
    }
    
    // Set bitbucket necessary fields
    // "https://Username:Password@bitbucket.org/Username/";
    func setBitBucketOptions(_ username: String, password: String, reponame: String){
        bitBucketURL = "https://\(username):\(password)@bitbucket.org/";
        bitBucketRepoName = reponame;
    }
    
    // Navigate to check out patha and clone the master branch.
    open func authendicate() {
        CloneCLI.cloneCLI.setApplicationName(CloneCLI.cloneCLI.applicatonName)
        CloneCLI.cloneCLI.setBitBucketOptions(CloneCLI.cloneCLI.bitBucketUsername, password: CloneCLI.cloneCLI.bitBucketPassword, reponame: CloneCLI.cloneCLI.bitBucketRepoName)
        
        printLog(LogType.Debug, text:"Navigate to the checkout Path: \(applicatonCheckOutPathName)")
        
        shell("pwd", applicatonCheckOutPathName)
        shell("ls", applicatonCheckOutPathName)
        
        let status = shellwithoptions(SystemCommands.git.rawValue, comments: ["clone", "-b", "master", "--verbose", "\(CloneCLI.cloneCLI.bitBucketURL)\(CloneCLI.cloneCLI.bitBucketRepoName).git"], path: applicatonCheckOutPathName)
        print("status : \(status)")
        
    }
    
    // Helps to setup the application name and Bitbucket necessary fields.
    open func authendicate(_ appname: String, username: String, password: String, reponame: String) {
        CloneCLI.cloneCLI.setApplicationName(appname)
        CloneCLI.cloneCLI.setBitBucketOptions(username, password: password, reponame: reponame)
    }
    
    // Get the default clone directory
    class func defaultCheckoutDirectory() -> String {
        var path = ""
        let fileManager = FileManager.default
        #if os(iOS)
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            path = "\(paths[0])/Clone"
        #elseif os(OSX)
            let urls = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)
            if let url = urls.last?.path {
                path = "\(url)/Clone"
            }
        #endif
        if !fileManager.fileExists(atPath: path) && path != ""  {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
            } catch _ {
            }
        }
        return path
    }
    
}


//MARK: -  Util Methods

/// Prints the log type with String and type color code.
public func printLog(_ type: LogType, text:String) {
    switch type {
    case .Info:
        ColorLog.blue(object: text)
        break;
    case .Verbose:
        ColorLog.purple(object: text)
        break;
    case .Warnings:
        ColorLog.yellow(object: text)
        break;
    case .Debug:
        ColorLog.green(object: text)
        break;
    case .Error:
        ColorLog.red(object: text)
        break;
    }
}

// Get input string from command line/terminal
public func getInput() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    let strData = String(data: inputData, encoding: String.Encoding.utf8)!
    
    return strData.trimmingCharacters(in: CharacterSet.newlines)
}

//MARK: -  Clone Util Methods

/// Public clone function help to start clone process.
public func clone() {
    CloneCLI.cloneCLI.authendicate()
}

/// Public clone function help to start clone process with necessary fields.
public func clone(_ appname: String, username: String, password: String, reponame: String) {
    CloneCLI.cloneCLI.authendicate(appname, username: username, password: password, reponame: reponame)
}





