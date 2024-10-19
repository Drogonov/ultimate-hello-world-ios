import ProjectDescription

// MARK: - Constants

public enum Constants {
    public static let organisationName = "Smart Lads Software"
    public static let rootBundleId = "com.drogonov.HelloWorldApp"
    public static let projectName = "HelloWorldApp"
}

// MARK: - Enums

public enum ProjectName: String, Codable, CaseIterable {
    case App

    case Common
    case CommonApplication
    case CommonNet
    case CommonTest
    case Deeplinks
    case DI
    case MasterComponents
    case HelloWorld
    case Magic
    case Net
    case Persistence
    case Resources
    case Services

    public var testName: String {
        "\(self.rawValue)Tests"
    }

    public var mockName: String {
        "\(self.rawValue)Mocks"
    }

    public var rootPath: String {
        switch self {
        case .App:
            return "App"

        case .Common:
            return "Frameworks/Common/Common"

        case .CommonApplication:
            return "Frameworks/Common/CommonApplication"

        case .CommonNet:
            return "Frameworks/Common/CommonNet"

        case .CommonTest:
            return "Frameworks/Common/CommonTest"

        case .Deeplinks:
            return "Frameworks/Deeplinks"

        case .DI:
            return "Frameworks/DI"

        case .MasterComponents:
            return "Frameworks/MasterComponents"

        case .HelloWorld:
            return "Frameworks/Modules/HelloWorld"

        case .Magic:
            return "Frameworks/Modules/Magic"

        case .Net:
            return "Frameworks/Net"

        case .Persistence:
            return "Frameworks/Persistence"

        case .Resources:
            return "Frameworks/Resources"

        case .Services:
            return "Frameworks/Services"
        }
    }

    public var path: String {
        "/\(rootPath)"
    }

    public var sourceryPath: String {
        "/Tests/Sourcery"
    }

    public var mockPath: String {
        "/Mocks/AutoMockable.generated.swift"
    }
}

public enum TargetType: String, Codable {
    case plain
    case test
    case mock
}

// MARK: - Structs

public struct TargetInfo: Codable {
    public let type: TargetType
    public let packages: [Package]
    public let dependencies: [TargetDependency]
    public let doesIncludeResources: Bool
    public let doesUseSourcery: Bool

    public init(
        type: TargetType,
        packages: [Package] = [],
        dependencies: [TargetDependency] = [],
        doesIncludeResources: Bool = false,
        doesUseSourcery: Bool = false
    ) {
        self.type = type
        self.packages = packages
        self.dependencies = dependencies
        self.doesIncludeResources = doesIncludeResources
        self.doesUseSourcery = doesUseSourcery
    }
}

// MARK: - Sourcery Generation

struct SourceryYamlConfig {
    let projectPath: String
    let fileName: String
    let sourcesPath: String
    let templatesPath: String
    let outputPath: String
    let argsTestableImports: String
    let argsImports: String
}
