// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
    import ProjectDescription
    let packageSettings = PackageSettings(
        productTypes: [
            "Swinject": .framework,
            "RealmSwift": .framework,
            "Realm": .framework,
            "ObjectMapper": .framework,
            "SnapKit": .framework
        ]
    )
#endif  

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4"),
        .package(url: "https://github.com/realm/realm-swift", from: "10.0.0")
    ]
)
