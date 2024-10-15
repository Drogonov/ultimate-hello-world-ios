import ProjectDescription

let project = Project(
    name: "CommonTest",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
    ],
    targets: [
        .target(
            name: "CommonTest",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.CommonTest",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "ObjectMapper"),
                .project(target: "CommonNet", path: "../CommonNet"),
                .xctest
            ]
        )
    ]
)
