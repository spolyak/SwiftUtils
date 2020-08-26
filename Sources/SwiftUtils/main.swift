func printUsage() {
    print("Usage: swift run SwiftUtils [lower|upper] foo.txt")
}
if CommandLine.arguments.count != 3 {
    printUsage()
} else if CommandLine.arguments[1].lowercased() == "lower" {
    let file = CommandLine.arguments[2]
    toLower(file: file)
} else if CommandLine.arguments[1].lowercased() == "upper" {
    let file = CommandLine.arguments[2]
    toUpper(file: file)
} else {
    printUsage()
}