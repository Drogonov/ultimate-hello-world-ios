import ProjectDescription

let project = Project(
    name: "HelloWorld",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4")
    ],
    targets: [
        .target(
            name: "HelloWorld",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.HelloWorld",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Swinject"),
                .project(target: "Services", path: "../../Services"),
                .project(target: "Resources", path: "../../Resources"),
                .project(target: "Net", path: "../../Net"),
                .project(target: "Deeplinks", path: "../../Deeplinks")
            ]
        ),
        .target(
            name: "HelloWorldTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.HelloWorldTests",
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
                .target(name: "HelloWorld"),
                .target(name: "HelloWorldMocks")
            ]
        ),
        .target(
            name: "HelloWorldMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.HelloWorldMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "HelloWorld")
            ]
        )
    ]
)
