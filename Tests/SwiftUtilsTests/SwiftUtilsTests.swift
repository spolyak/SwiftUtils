import XCTest
import class Foundation.Bundle

final class SwiftUtilsTests: XCTestCase {
    func processRunner(arguments: [String]) -> String {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return ""
        }

        let fooBinary = productsDirectory.appendingPathComponent("SwiftUtils")

        let process = Process()
        process.executableURL = fooBinary
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe

        do {
          try process.run()
          process.waitUntilExit()

          let data = pipe.fileHandleForReading.readDataToEndOfFile()
          let output = String(data: data, encoding: .utf8)
          return output ?? ""
        } catch {
          print("Error: \(error)")
          return ""
        }
    }  

    func testUpper() throws {
        let arguments = ["upper", "./Data/fox-lower.txt"]
        let correctOutput = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG\n"
        let output = processRunner(arguments: arguments)
        XCTAssertEqual(output, correctOutput)   
    }

    func testLower() throws {
        let arguments = ["lower", "./Data/fox-upper.txt"]
        let correctOutput = "the quick brown fox jumps over the lazy dog\n"
        let output = processRunner(arguments: arguments)
        XCTAssertEqual(output, correctOutput)   
    }    

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testUpper", testUpper),
        ("testLower", testLower),
    ]
}
