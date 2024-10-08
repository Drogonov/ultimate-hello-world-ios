import ProjectDescription

let project = Project(
    name: "DI",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4"),
    ],
    targets: [
        .target(
            name: "DI",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.DI",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Swinject")
            ]
        )
    ]
)
