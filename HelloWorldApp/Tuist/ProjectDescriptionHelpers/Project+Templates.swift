import ProjectDescription
import Foundation

public func generateProject(projectName: ProjectName, targets: [TargetInfo]) -> Project {
    let targets: [Target] = targets.compactMap { target in
        let name: String
        let product: Product
        let sources: SourceFilesList

        switch target.type {
        case .plain:
            name = projectName.rawValue
            product = .framework
            sources = ["Sources/**"]

        case .test:
            name = projectName.testName
            product = .unitTests
            sources = ["Tests/**"]

        case .mock:
            name = projectName.mockName
            product = .framework
            sources = ["Mocks/**"]
        }

        let bundleId = "\(Constants.rootBundleId).\(name)"

        var resources: ResourceFileElements?
        if target.doesIncludeResources {
            resources = ["Resources/**"]
        }

        var scripts: [TargetScript] = []
        if target.doesUseSourcery {
            scripts = [
                generateSourceryScript(pathToTarget: projectName.path)
            ]
        }

        return .target(
            name: name,
            destinations: .iOS,
            product: product,
            bundleId: bundleId,
            infoPlist: .default,
            sources: sources,
            resources: resources,
            scripts: scripts,
            dependencies: target.dependencies
        )
    }

    let project = Project(
        name: projectName.rawValue,
        organizationName: Constants.organisationName,
        targets: targets
    )

    return project
}

public func generateDependency(name: ProjectName) -> TargetDependency {
    .project(
        target: name.rawValue,
        path: "\(FileManager.default.currentDirectoryPath)\(name.path)"
    )
}

public func generateTargetReference(name: ProjectName, isForTest: Bool = false) -> TargetReference {
    .project(
        path: Path(stringLiteral: name.rootPath),
        target: isForTest ? name.testName : name.rawValue
    )
}

public func generateTargetsReferences(names: [ProjectName]) -> [TargetReference] {
    names.compactMap { name in
        generateTargetReference(name: name)
    }
}

public func generateTestableTargetsReferences(names: [ProjectName]) -> [TestableTarget] {
    names.compactMap { name in
            .testableTarget(
                target: generateTargetReference(name: name, isForTest: true)
            )
    }
}

public func generateSourceryScript(pathToTarget: String) -> TargetScript {
    let currentDirectoryPath = FileManager.default.currentDirectoryPath
    let localDirectoryPath = "\(currentDirectoryPath)\(pathToTarget)"

    let scriptPath = filePath(currentPath: currentDirectoryPath, fileName: "sourcery.sh")
    let sourceryScriptPath = filePath(currentPath: currentDirectoryPath, fileName: "sourcery").pathString
    let sourceryConfigPath = filePath(currentPath: localDirectoryPath, fileName: "sourcery.yml").pathString

    return .pre(
        path: scriptPath,
        arguments: [sourceryScriptPath, sourceryConfigPath],
        name: "Sourcery",
        basedOnDependencyAnalysis: false
    )
}

private func filePath(currentPath: String, fileName: String) -> Path {
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
