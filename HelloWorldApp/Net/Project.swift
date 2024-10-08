import ProjectDescription

let project = Project(
    name: "Net",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
    ],
    targets: [
        .target(
            name: "Net",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Net",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "ObjectMapper"),
                .project(target: "MasterComponents", path: "../MasterComponents"),
                .project(target: "Persistence", path: "../Persistence"),
                .project(target: "CommonNet", path: "../Common/CommonNet"),
            ]
        )
    ]
)
