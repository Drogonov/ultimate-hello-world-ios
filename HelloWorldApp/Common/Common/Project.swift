import ProjectDescription

let project = Project(
    name: "Common",
    organizationName: "Smart Lads Software",
    targets: [
        .target(
            name: "Common",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Common",
            infoPlist: .default,
            sources: ["Sources/**"]
        )
    ]
)
