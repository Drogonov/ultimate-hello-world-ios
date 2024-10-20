import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Services,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "ObjectMapper"),
                .external(name: "Swinject"),
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
