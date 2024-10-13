import ProjectDescription

let project = Project(
    name: "Persistence",
    organizationName: "Smart Lads Software",
    packages: [
        .package(url: "https://github.com/realm/realm-swift", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "Persistence",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.Persistence",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "RealmSwift")
            ]
        ),
        .target(
            name: "PersistenceTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.drogonov.HelloWorldApp.PersistenceTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "Persistence"),
                .target(name: "PersistenceMocks")
            ]
        ),
        .target(
            name: "PersistenceMocks",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.drogonov.HelloWorldApp.PersistenceMocks",
            infoPlist: .default,
            sources: ["Mocks/**"],
            dependencies: [
                .target(name: "Persistence")
            ]
        ),
    ]
)
