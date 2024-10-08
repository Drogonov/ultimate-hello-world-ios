import ProjectDescription

let project = Project(
    name: "HelloWorldApp",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4")
    ],
    targets: [
        .target(
            name: "HelloWorldApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.drogonov.HelloWorldApp",
            infoPlist: "HelloWorldApp/Supporting Files/Info.plist",
            sources: ["HelloWorldApp/**"],
            entitlements: "HelloWorldApp/Supporting Files/HelloWorldApp.entitlements",
            dependencies: [
                .package(product: "ObjectMapper"),
                .package(product: "SnapKit"),
                .package(product: "Swinject"),
                .project(target: "DI", path: "DI"),
                .project(target: "Resources", path: "Resources"),
                .project(target: "MasterComponents", path: "MasterComponents"),
                .project(target: "Persistence", path: "Persistence"),
                .project(target: "Net", path: "Net"),
                .project(target: "Services", path: "Services"),
                .project(target: "Deeplinks", path: "Deeplinks"),
                .project(target: "HelloWorld", path: "Modules/HelloWorld"),
                .project(target: "Magic", path: "Modules/Magic"),
                .project(target: "Common", path: "Common/Common"),
                .project(target: "CommonNet", path: "Common/CommonNet"),
                .project(target: "CommonUI", path: "Common/CommonUI"),
                .project(target: "CommonApplication", path: "Common/CommonApplication")
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_ENTITLEMENTS": "HelloWorldApp/Supporting Files/HelloWorldApp.entitlements"
                ]
            )
        ),
        .target(
            name: "HelloWorldAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldAppTests",
            infoPlist: .default,
            sources: ["HelloWorldAppTests/**"],
            resources: [],
            dependencies: [
                .target(name: "HelloWorldApp")
            ]
        )
    ]
//    schemes: [debugScheme]
)
