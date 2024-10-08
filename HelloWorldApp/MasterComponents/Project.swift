import ProjectDescription

let project = Project(
    name: "MasterComponents",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
    ],
    targets: [
        .target(
            name: "MasterComponents",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.MasterComponents",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "Resources", path: "../Resources"),
                .project(target: "CommonApplication", path: "../Common/CommonApplication")
            ]
        ),
        .target(
            name: "MasterComponentsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.MasterComponentsTests",
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
                .target(name: "MasterComponents"),
                .target(name: "MasterComponentsMocks")
            ]
        ),
        .target(
            name: "MasterComponentsMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.MasterComponentsMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "MasterComponents")
            ]
        ),
    ]
)
