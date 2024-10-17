import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Persistence,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/realm/realm-swift", from: "10.0.0")
            ],
            dependencies: [
                .package(product: "RealmSwift"),
                generateDependency(name: .CommonNet),
                generateDependency(name: .DI)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.Persistence.rawValue),
                .target(name: ProjectName.Persistence.mockName)
            ],
            doesUseSourcery: false
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.Persistence.rawValue),
            ]
        ),
    ]
)
