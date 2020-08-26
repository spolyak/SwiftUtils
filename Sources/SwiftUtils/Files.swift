import Foundation

func getFile(file: String) -> String {
    let inputFile = file 
    let completeUrl = URL(fileURLWithPath: inputFile)
    do {
        let text = try String(contentsOf: completeUrl, encoding: .utf8)
         return text
    } catch {
        print("Unable to read file: \(completeUrl)")
        print("Error: \(error)")
        return ""
    }
}
func toLower(file: String) {
    print(getFile(file: file).lowercased())
}

func toUpper(file: String) {
    print(getFile(file: file).uppercased())
}