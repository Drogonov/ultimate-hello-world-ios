import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Deeplinks,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "ObjectMapper"),
                .external(name: "Swinject"),
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
