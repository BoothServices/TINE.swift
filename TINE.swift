
//  TINE.swift
// 
//  This program is released under the GNU General Public Licence version 2 or (at your option)
//  any later version. 
//
//  Written by Colton Booth on 2016-03-12.
//  
//
import Foundation

#if os(Linux)
import Glibc
#else
import Darwin
#endif

///////////functions/////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

//function for getting input
func getInput() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    return NSString(data: inputData, encoding:NSUTF8StringEncoding)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

//function for writing files
func writeToDocumentsFile(fileName:String,value:String) throws {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    let path = documentsPath.stringByAppendingPathComponent(fileName)
    try value.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)

}
//function for reading files
func readFromDocumentsFile(fileName:String) throws -> String {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    let path = documentsPath.stringByAppendingPathComponent(fileName)
    let checkValidation = NSFileManager.defaultManager()
    var file:String
    
    if checkValidation.fileExistsAtPath(path) {
        try file = String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
    } else {
        file = "*ERROR* \(fileName) does not exist."
    }
    
    return file
}


///////////end of functions//////////////////////////////////////////
////////////////////////////////////////////////////////////////////



//Starting the app....

print("Welcome To TINE! Would you like to (Open) a file or write a (New) one?");
var askNewOrOpen = getInput()

let isNew =  ["new", "n", "New", "NEW", "New one", "new one", "New File", "new file", "New file", "NeW", "nEW", "neW", "N"].contains {
    askNewOrOpen.compare($0, options: [.CaseInsensitiveSearch]) == .OrderedSame //Puts all "new" in array
        }
let isOpen =  ["Open", "open", "OPEN", "O", "o", "Open File", "open file", "Open file", "Open Sesame", "ok", "Ok", "fetch"].contains {
    askNewOrOpen.compare($0, options: [.CaseInsensitiveSearch]) == .OrderedSame //Puts all "open" in an array
}

if isNew {
    // User answered New
    print("Please name your new file, WITH the file extension")
    var newFileName = getInput()
    print("Enter the text to be saved, here. As of right now only one line :-(")
    var newFileText = getInput()
    print("creating file.......")
    try writeToDocumentsFile(" \(newFileName)", value: "\(newFileText)")//using the above vars as strings
    print("Done!")
    
}
    
    else if isOpen {
    // User answered Open
    print("Please enter a .txt file that exists in the documents folder to be read. ")
    //code to display the chosen file in the editor
    var openFileName = getInput()
    let openFile = try readFromDocumentsFile(openFileName)
    print(openFile)
    
}

else {
        print("Bye!")
        exit(1)
}





