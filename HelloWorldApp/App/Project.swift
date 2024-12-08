import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Constants.projectName,
    organizationName: Constants.organisationName,
    targets: [
        .target(
            name: ProjectName.App.rawValue,
            destinations: .iOS,
            product: .app,
            bundleId: "\(Constants.rootBundleId).\(ProjectName.App.rawValue)",
            infoPlist: "Sources/Supporting Files/Info.plist",
            sources: ["Sources/**"],
            entitlements: "Sources/Supporting Files/App.entitlements",
            dependencies: [
                .external(name: "ObjectMapper"),
                .external(name: "SnapKit"),
                .external(name: "Swinject"),
                .external(name: "RealmSwift"),
                .external(name: "KeychainAccess"),
                generateDependency(name: .DI),
                generateDependency(name: .Resources),
                generateDependency(name: .MasterComponents),
                generateDependency(name: .Persistence),
                generateDependency(name: .Net),
                generateDependency(name: .Services),
                generateDependency(name: .Deeplinks),
                generateDependency(name: .HelloWorld),
                generateDependency(name: .Magic),
                generateDependency(name: .Auth),
                generateDependency(name: .Common),
                generateDependency(name: .CommonNet),
                generateDependency(name: .CommonApplication),
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_ENTITLEMENTS": "Sources/Supporting Files/App.entitlements"
                ]
            )
        ),
        .target(
            name: ProjectName.App.testName,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(Constants.rootBundleId).\(ProjectName.App.testName)",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: ProjectName.App.rawValue)
            ]
        )
    ]
)

