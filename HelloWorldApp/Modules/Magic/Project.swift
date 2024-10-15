import ProjectDescription

let project = Project(
    name: "Magic",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4")
    ],
    targets: [
        .target(
            name: "Magic",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Magic",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Swinject"),
                .project(target: "Services", path: "../../Services"),
                .project(target: "Resources", path: "../../Resources"),
                .project(target: "Net", path: "../../Net"),
                .project(target: "CommonApplication", path: "../../Common/CommonApplication"),
                .project(target: "Common", path: "../../Common/Common"),
            ]
        ),
        .target(
            name: "MagicTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.MagicTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            scripts: [
                .pre(
                    path: "./Tests/Sourcery/sourcery.sh",
                    arguments: ["${PROJECT_DIR}/../..", "${PROJECT_DIR}"],
                    name: "Sourcery",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .target(name: "Magic"),
                .target(name: "MagicMocks"),
                .project(target: "CommonTest", path: "../../Common/CommonTest"),
            ]
        ),
        .target(
            name: "MagicMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.MagicMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "Magic"),
                .project(target: "CommonApplication", path: "../../Common/CommonApplication"),
                .project(target: "Common", path: "../../Common/Common"),
            ]
        )
    ]
)
