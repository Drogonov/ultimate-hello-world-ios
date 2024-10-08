import ProjectDescription

let project = Project(
    name: "CommonNet",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
    ],
    targets: [
        .target(
            name: "CommonNet",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.CommonNet",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "ObjectMapper"),
                .project(target: "Common", path: "../Common")
            ]
        )
    ]
)
