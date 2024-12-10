import ProjectDescription
import Foundation

// MARK: - Project Generation

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

            let config = getSourceryYamlConfig(name: projectName)
            createSourceryYamlConfig(config: config)
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

// MARK: - Target Generation

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

// MARK: - Sourcery Generation

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

private func getSourceryYamlConfig(name: ProjectName) -> SourceryYamlConfig {
    let currentDirectoryPath = FileManager.default.currentDirectoryPath
    let args = getSourceryYamlArgs(name: name)

    return SourceryYamlConfig(
        name: name,
        projectPath: "\(currentDirectoryPath)\(name.path)\(name.sourceryPath)",
        fileName: "sourcery.yml",
        sourcesPath: "\(currentDirectoryPath)\(name.path)",
        templatesPath: filePath(currentPath: currentDirectoryPath, fileName: "AutoMockable.stencil", returnDirectoryOnly: true).pathString,
        outputPath: "\(currentDirectoryPath)\(name.path)\(name.mockPath)",
        argsTestableImports: args.argsTestableImports,
        argsImports: args.argsImports
    )
}

private func getSourceryYamlArgs(name: ProjectName) -> (argsTestableImports: String, argsImports: String) {
    let argsTestableImports: String
    let argsImports: String

    switch name {
    case .CommonApplication:
        argsTestableImports = "[CommonApplication]"
        argsImports = "[Common]"

    case .Deeplinks:
        argsTestableImports = "[Deeplinks]"
        argsImports = "[Common, CommonApplication]"

    case .MasterComponents:
        argsTestableImports = "[MasterComponents]"
        argsImports = "[UIKit, Common, Resources]"

    case .Auth:
        argsTestableImports = "[Auth]"
        argsImports = "[Common, CommonApplicationMocks, CommonApplication, DI]"

    case .HelloWorld:
        argsTestableImports = "[HelloWorld]"
        argsImports = "[Common, CommonApplicationMocks, CommonApplication, DI]"

    case .Magic:
        argsTestableImports = "[Magic]"
        argsImports = "[Common, CommonApplicationMocks, CommonApplication, DI]"

    case .Persistence:
        argsTestableImports = "[Persistence]"
        argsImports = "[]"

    case .Services:
        argsTestableImports = "[Services]"
        argsImports = "[CommonNet , Common]"

    default:
        argsTestableImports = "[]"
        argsImports = "[]"
    }

    return (argsTestableImports: argsTestableImports, argsImports: argsImports)
}

private func createSourceryYamlConfig(config: SourceryYamlConfig) {
    let fileContent = """
    # Generated from Tuist/ProjectDescriptionHelpers/Project+Dependencies.swift by createSourceryYamlConfig
    sources:
      - \(config.sourcesPath)
    templates:
      - \(config.templatesPath)
    output:
      path: \(config.outputPath)
    args:
      autoMockableTestableImports: \(config.argsTestableImports)
      autoMockableImports: \(config.argsImports)
    """

    let filePath = "\(config.projectPath)/\(config.fileName)"

    do {
        try fileContent.write(toFile: filePath, atomically: true, encoding: .utf8)
        print("YAML file created at \(config.name.rawValue)")
    } catch {
        print("Failed to create YAML file: \(error.localizedDescription)")
    }
}

// MARK: - Private Methods

private func filePath(currentPath: String, fileName: String, returnDirectoryOnly: Bool = false) -> Path {
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
                        return returnDirectoryOnly ? path : fullPath
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
