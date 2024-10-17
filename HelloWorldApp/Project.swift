import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: ProjectName.HellowWorldApp.rawValue,
    organizationName: Constants.organisationName,
    packages: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4"),
        .package(url: "https://github.com/realm/realm-swift", from: "10.0.0")
    ],
    targets: [
        .target(
            name: ProjectName.HellowWorldApp.rawValue,
            destinations: .iOS,
            product: .app,
            bundleId: Constants.rootBundleId,
            infoPlist: "Sources/Supporting Files/Info.plist",
            sources: ["Sources**"],
            entitlements: "Sources/Supporting Files/HelloWorldApp.entitlements",
            dependencies: [
                .package(product: "ObjectMapper"),
                .package(product: "SnapKit"),
                .package(product: "Swinject"),
                .package(product: "RealmSwift"),
                generateDependency(name: .DI),
                generateDependency(name: .Resources),
                generateDependency(name: .MasterComponents),
                generateDependency(name: .Persistence),
                generateDependency(name: .Net),
                generateDependency(name: .Services),
                generateDependency(name: .Deeplinks),
                generateDependency(name: .HelloWorld),
                generateDependency(name: .Magic),
                generateDependency(name: .Common),
                generateDependency(name: .CommonNet),
                generateDependency(name: .CommonApplication),
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_ENTITLEMENTS": "Sources/Supporting Files/HelloWorldApp.entitlements"
                ]
            )
        ),
        .target(
            name: ProjectName.HellowWorldApp.testName,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(Constants.rootBundleId)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: ProjectName.HellowWorldApp.rawValue)
            ]
        )
    ]
// # TODO: Add target for proper tests of the app
//    schemes: [debugScheme]
)
