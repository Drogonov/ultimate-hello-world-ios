import ProjectDescription

// MARK: - Constants

public enum Constants {
    static let organisationName = "Smart Lads Software"
    static let rootBundleId = "com.drogonov.HelloWorldApp"
}

// MARK: - Enums

public enum ProjectName: String, Codable {
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

    public var path: String {
        switch self {
        case .Common:
            return "/Common/Common"

        case .CommonApplication:
            return "/Common/CommonApplication"

        case .CommonNet:
            return "/Common/CommonNet"

        case .CommonTest:
            return "/Common/CommonTest"

        case .Deeplinks:
            return "/Deeplinks"

        case .DI:
            return "/DI"

        case .MasterComponents:
            return "/MasterComponents"

        case .HelloWorld:
            return "/Modules/HelloWorld"

        case .Magic:
            return "/Modules/Magic"

        case .Net:
            return "/Net"

        case .Persistence:
            return "/Persistence"

        case .Resources:
            return "/Resources"

        case .Services:
            return "/Services"
        }
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
