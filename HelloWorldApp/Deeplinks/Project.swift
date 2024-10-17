import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Deeplinks,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4"),
                .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0")
            ],
            dependencies: [
                .package(product: "Swinject"),
                .package(product: "ObjectMapper"),
                generateDependency(name: .DI),
                generateDependency(name: .Common),
                generateDependency(name: .CommonNet),
                generateDependency(name: .MasterComponents),
                generateDependency(name: .Persistence),
                generateDependency(name: .Magic)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.Deeplinks.rawValue),
                .target(name: ProjectName.Deeplinks.mockName)
            ],
            doesUseSourcery: true
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.Deeplinks.rawValue),
            ]
        ),
    ]
)
