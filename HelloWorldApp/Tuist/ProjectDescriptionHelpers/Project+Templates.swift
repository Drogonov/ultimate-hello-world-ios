import ProjectDescription
import Foundation

extension Project {
    public static func filePath(currentPath: String, fileName: String) -> Path {
        let fileManager = FileManager.default

        // This function recursively searches for the file
        func searchDirectory(path: String) -> String? {
            do {
                let items = try fileManager.contentsOfDirectory(atPath: path)
                for item in items {
                    let fullPath = (path as NSString).appendingPathComponent(item)
                    var isDirectory: ObjCBool = false

                    if fileManager.fileExists(atPath: fullPath, isDirectory: &isDirectory) {
                        if isDirectory.boolValue {
                            // Recursively search within subdirectory
                            if let foundPath = searchDirectory(path: fullPath) {
                                return foundPath
                            }
                        } else if item == fileName {
                            // File found
                            return fullPath
                        }
                    }
                }
            } catch {
                print("Error accessing directory: \(error.localizedDescription)")
            }
            return nil
        }

        // Start searching from the current project directory
        return Path(stringLiteral: searchDirectory(path: currentPath) ?? "./")
    }

    public static func generateSourceryScript(pathToTarget: String) -> TargetScript {
        let fileManager = FileManager.default
        let currentDirectoryPath = fileManager.currentDirectoryPath
        let localDirectoryPath = "\(currentDirectoryPath)\(pathToTarget)"

        let scriptPath = filePath(currentPath: localDirectoryPath, fileName: "sourcery.sh")
        let sourceryScriptPath = filePath(currentPath: currentDirectoryPath, fileName: "sourcery").pathString
        let sourceryConfigPath = filePath(currentPath: localDirectoryPath, fileName: "sourcery.yml").pathString

        return .pre(
            path: scriptPath,
            arguments: [sourceryScriptPath, sourceryConfigPath],
            name: "Sourcery",
            basedOnDependencyAnalysis: false
        )
    }
}
