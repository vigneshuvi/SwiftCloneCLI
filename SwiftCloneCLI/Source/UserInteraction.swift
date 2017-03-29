//
//  UserInteraction.swift
//  SwiftCloneCLI
//
//  Created by Vignesh on 28/03/17.
//  Copyright © 2017 vigneshuvi. All rights reserved.
//

import Foundation

// Class is help to start the user interaction/static workflow.
class UserInteraction {
    
    // User interative method to start operaions.
    func startCloneWithInteractiveMode() {
        // Welcome message
        printLog(LogType.Debug, text:"Welcome to SwiftCloneCLI. This program helps to clone the repo from BitBucket.!!!")
        doOperation(CloneSteps.GetApplicationName, shouldQuit: false)
    }
    
    // Do User interation with necessary steps.
    func doOperation(_ step: CloneSteps, shouldQuit: Bool) {
         var nextStep:CloneSteps = step;
        var shouldQuit = shouldQuit
        while !shouldQuit {
            
            switch nextStep {
            case .GetApplicationName:
                printLog(LogType.Info, text:"Please enter application name:")
                let appName = getInput()
                if appName.characters.count > 0 {
                    CloneCLI.cloneCLI.applicatonName = appName;
                    nextStep = CloneSteps.GetBitBucketUserName
                } else {
                    printLog(LogType.Error, text:"Please enter valid application name!")
                }
            case .GetBitBucketUserName:
                printLog(LogType.Info, text:"Please enter BitBucket Username:")
                let username = getInput()
                if username.characters.count > 0 {
                    CloneCLI.cloneCLI.bitBucketUsername = username;
                    nextStep = CloneSteps.GetBitBucketPassword
                } else {
                    printLog(LogType.Error, text:"Please enter valid username name!")
                }
            case .GetBitBucketPassword:
                printLog(LogType.Info, text:"Please enter BitBucket Password:")
                let password = getInput()
                if password.characters.count > 0 {
                    CloneCLI.cloneCLI.bitBucketPassword = password.replacingOccurrences(of: "@", with: "%40");
                    nextStep = CloneSteps.GetBitBucketRepo
                } else {
                    printLog(LogType.Error, text:"Please enter valid password name!")
                }
            case .GetBitBucketRepo:
                printLog(LogType.Info, text:"Please enter BitBucket Reponame:")
                let repoName = getInput()
                if repoName.characters.count > 0 {
                    CloneCLI.cloneCLI.bitBucketRepoName = repoName;
                    nextStep = CloneSteps.GetBitBucketCheckoutPath
                } else {
                    printLog(LogType.Error, text:"Please enter valid repo name!")
                }
            case .GetBitBucketCheckoutPath:
                printLog(LogType.Info, text:"Please enter BitBucket Checkout path(Info: -1 - Helps to clone in default path.):")
                let checkoutPath = getInput()
                if checkoutPath.characters.count > 0 && checkoutPath != "" {
                    if checkoutPath != "-1"  {
                        let fileManager = FileManager.default
                        if !fileManager.fileExists(atPath: checkoutPath)  {
                            do {
                                try fileManager.createDirectory(atPath: checkoutPath, withIntermediateDirectories: false, attributes: nil)
                                CloneCLI.cloneCLI.applicatonCheckOutPathName = checkoutPath;
                                nextStep = CloneSteps.StartProcess
                            } catch _ {
                                printLog(LogType.Error, text:"Unable to find/create directory in given path")
                            }
                        }
                    } else {
                        printLog(LogType.Info, text:"Default path: \(CloneCLI.cloneCLI.applicatonCheckOutPathName)")
                        nextStep = CloneSteps.StartProcess
                    }
                }  else {
                    printLog(LogType.Error, text:"Please valid checkout path!")
                }
            case .StartProcess :
                //clone();
                shouldQuit = true
            case .quit:
                shouldQuit = true
           
            }
        }
        
        if shouldQuit {
            clone();
        }
    }
    
    // Do static operation with commandline arguments
    func startCloneWithStaticMode() {
        // Welcome message
        printLog(LogType.Debug, text:"Welcome to SwiftCloneCLI. This program helps to clone the repo from BitBucket.!!!")
    
    }
}

