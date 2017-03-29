[![Language Swift 3](https://img.shields.io/badge/Language-Swift%203-orange.svg)](https://developer.apple.com/swift)


# SwiftCloneCLI
SwiftCloneCLI helps to clone bitbucket repository with user interaction from terminal. 
This tutorial app is helps to create OWN CLI using Swift-3.

## Features

- User interactive with necessary steps to clone.
- Able to customize CLI from sample project.
- Dependencies git, base should be there in the system.


## Screenshot:

### Example 1
```swift

// First User Object
let user1:NSMutableDictionary = NSMutableDictionary()
user1.setObject("vignesh", forKey: "name" as NSCopying);
user1.setObject("vigneshuvi@gmail.com", forKey: "email" as NSCopying);

// Secound User Object
let user2:NSMutableDictionary = NSMutableDictionary()
user2.setObject("vinoth", forKey: "name" as NSCopying);
user2.setObject("vinoth@gmail.com", forKey: "email" as NSCopying);

// Add fields into columns of CSV headers
let fields:NSMutableArray = NSMutableArray()
fields.add("name");
fields.add("email");

// Add dictionary into rows of CSV Array
let data:NSMutableArray  = NSMutableArray()
data.add(user1);
data.add(user2);

let filePath:String = SwiftCSVExport.exportCSV("userlist",fields: fields,values: data);
print(filePath)

```

### Example 2
```swift


// First User Object
let user1:NSMutableDictionary = NSMutableDictionary()
user1.setObject("vignesh", forKey: "name" as NSCopying);
user1.setObject("vigneshuvi@gmail.com", forKey: "email" as NSCopying);

// Secound User Object
let user2:NSMutableDictionary = NSMutableDictionary()
user2.setObject("vinoth", forKey: "name" as NSCopying);
user2.setObject("vinoth@gmail.com", forKey: "email" as NSCopying);

// Add dictionary into rows of CSV Array
let data:NSMutableArray  = NSMutableArray()
data.add(user1);
data.add(user2);

let filePath:String = SwiftCSVExport.exportCSV("userlist",fields: ["name", "email"],values: data);
print(filePath)

```

### Example 2
```swift


// Generate CSV file
let user1:NSMutableDictionary = NSMutableDictionary()
user1.setObject("vignesh", forKey: "name" as NSCopying);
user1.setObject("vigneshuvi@gmail.com", forKey: "email" as NSCopying);

let user2:NSMutableDictionary = NSMutableDictionary()
user2.setObject("vinoth", forKey: "name" as NSCopying);
user2.setObject("vinoth@gmail.com", forKey: "email" as NSCopying);

let data:NSMutableArray  = NSMutableArray()
data.add(user1);
data.add(user2);

let filePath:String = SwiftCSVExport.exportCSV("userlist",fields: ["name", "email"],values: data);
print(filePath)

```

### Example 3

```swift

// Able to convert JSON string into CSV.
let string = "[{\"name\":\"vignesh\",\"email\":\"vigneshuvi@gmail.com\"},{\"name\":\"vinoth\",\"email\":\"vinoth@gmail.com\"}]";
let filePath:String = exportCSV("userlist", fields:["name","email"], values:string);
print(filePath)

// Read File
let fileDetails = readCSV(filePath);

// Use 'SwiftLoggly' pod framework to print the Dictionary
if fileDetails.allKeys.count > 0 {
    loggly(LogType.Info, dictionary: fileDetails)
}


```

### Write Output:

```swift

Output: userlist.csv

name,email
vignesh,vigneshuvi@gmail.com
vinoth,vinoth@gmail.com

```

### Example 4

```swift

// Read File
let fileDetails = readCSV(filePath);

// Use 'SwiftLoggly' pod framework to print the Dictionary
if fileDetails.allKeys.count > 0 {
    loggly(LogType.Info, dictionary: fileDetails)
}


```

### Read Output:

```swift

[💙 Info -  Feb 7, 2017, 4:19:23 PM]: {
  "rows" : [
    {
      "name" : "vignesh",
      "email" : "vigneshuvi@gmail.com"
    },
    {
      "name" : "vinoth",
      "email" : "vinoth@gmail.com"
    }
  ],
  "name" : "userlist.csv",
  "fields" : [
    "name",
    "email"
  ]
}


```


That will create a CSV file in the proper directory on both OS X and iOS.

OS X CSV files will be created in the OS X Exports directory (found under: /Library/Exports). The iOS CSV files will be created in your apps document directory under a folder called Exports.

## Configuration

There are a few configurable options in SwiftCSVExport.

```swift

//Set the name of the csv file
CSVExport.export.fileName = "Sample" //default is "csvfile"

//Set the directory in which the csv files will be written
CSVExport.export.directory = "/Library/XXX-folder-name-XXX" //default is the standard exporting directory for each platform.

```

## Installation

### CocoaPods

Check out [Get Started](http://cocoapods.org/) tab on [cocoapods.org](http://cocoapods.org/).

To use SwiftCSVExport in your project add the following 'Podfile' to your project

	  source 'https://github.com/CocoaPods/Specs.git'
	  platform :ios, '8.0'
	  use_frameworks!

	  pod 'SwiftCSVExport'

Then run:

    pod install || pod update

### Carthage


To use SwiftCSVExport in your project create/update 'Cartfile.private' file into your project

    // Require version 1.x
    
    github "vigneshuvi/SwiftCSVExport"

Then run:

    carthage update

### Swift Package Manager for Vapor

You need to add to dependencies in your 'Package.swift' and fetch Swift module using terminal comment.

// Vapor

dependencies: [
        .Package(url: "https://github.com/vigneshuvi/SwiftCSVExport.git", majorVersion: 1, minor: 0)
        ],

Then run:

    vapor build || vapor xcode


// Importing header

import SwiftCSVExport


## License

SwiftCSVExport is licensed under the MIT License.

## Contact

### Vignesh Kumar
* http://vigneshuvi.github.io