//
//  main.swift
//  SwiftCloneCLI
//
//  Created by Vignesh on 28/03/17.
//  Copyright © 2017 vigneshuvi. All rights reserved.
//

import Foundation

let userInteration = UserInteraction()
if CommandLine.argc < 4 {
   userInteration.startCloneWithInteractiveMode()
} else {
    userInteration.startCloneWithStaticMode();
}

