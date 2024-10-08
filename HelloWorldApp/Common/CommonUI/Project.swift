import ProjectDescription

let project = Project(
    name: "CommonUI",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1")
    ],
    targets: [
        .target(
            name: "CommonUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.CommonUI",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "Common", path: "../Common")
            ]
        )
    ]
)
