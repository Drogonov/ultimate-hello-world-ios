import ProjectDescription

let project = Project(
    name: "CommonApplication",
    organizationName: "Smart Lads Software",
    targets: [
        .target(
            name: "CommonApplication",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.CommonApplication",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "CommonNet", path: "../CommonNet"),
                .project(target: "Common", path: "../Common"),
            ]
        ),
        .target(
            name: "CommonApplicationTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.CommonApplicationTests",
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
                .target(name: "CommonApplication"),
                .target(name: "CommonApplicationMocks")
            ]
        ),
        .target(
            name: "CommonApplicationMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.CommonApplicationMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "CommonApplication")
            ]
        )
    ]
)
