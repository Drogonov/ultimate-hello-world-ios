import ProjectDescription

let project = Project(
    name: "Services",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4")
    ],
    targets: [
        .target(
            name: "Services",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Services",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Swinject"),
                .package(product: "SnapKit"),
                .package(product: "ObjectMapper"),
                .project(target: "DI", path: "../DI"),
                .project(target: "Common", path: "../Common/Common"),
                .project(target: "Net", path: "../Net"),
                .project(target: "Persistence", path: "../Persistence")
            ]
        ),
        .target(
            name: "ServicesTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.ServicesTests",
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
                .target(name: "Services"),
                .target(name: "ServicesMocks")
            ]
        ),
        .target(
            name: "ServicesMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.ServicesMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "Services")
            ]
        ),
    ]
)
