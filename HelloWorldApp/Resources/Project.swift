import ProjectDescription

let project = Project(
    name: "Resources",
    organizationName: "Smart Lads Software",
    targets: [
        .target(
            name: "Resources",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Resources",
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Common", path: "../Common/Common"),
            ]
        )
    ]
)
