import ProjectDescription

let project = Project(
    name: "Deeplinks",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0")
    ],
    targets: [
        .target(
            name: "Deeplinks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Deeplinks",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Swinject"),
                .package(product: "ObjectMapper"),
                .project(target: "DI", path: "../DI"),
                .project(target: "Common", path: "../Common/Common"),
                .project(target: "CommonNet", path: "../Common/CommonNet"),
                .project(target: "MasterComponents", path: "../MasterComponents"),
                .project(target: "Persistence", path: "../Persistence"),
                .project(target: "Magic", path: "../Modules/Magic"),
            ]
        ),
        .target(
            name: "DeeplinksTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.DeeplinksTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            scripts: [
                .pre(
                    path: "./Tests/Sourcery/sourcery.sh",
                    arguments: ["${PROJECT_DIR}/..", "${PROJECT_DIR}"],
                    name: "Sourcery",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .target(name: "Deeplinks"),
                .target(name: "DeeplinksMocks")
            ]
        ),
        .target(
            name: "DeeplinksMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.DeeplinksMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "Deeplinks")
            ]
        ),
    ]
)
