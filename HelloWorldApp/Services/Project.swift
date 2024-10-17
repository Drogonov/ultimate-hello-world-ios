import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Services,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
                .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4")
            ],
            dependencies: [
                .package(product: "Swinject"),
                .package(product: "ObjectMapper"),
                generateDependency(name: .DI),
                generateDependency(name: .Common),
                generateDependency(name: .Net),
                generateDependency(name: .Persistence)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.Services.rawValue),
                .target(name: ProjectName.Services.mockName),
                generateDependency(name: .CommonTest)
            ],
            doesIncludeResources: true,
            doesUseSourcery: true
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.Services.rawValue),
            ]
        ),
    ]
)
