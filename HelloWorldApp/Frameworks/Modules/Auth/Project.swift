import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Auth,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "Swinject"),
                generateDependency(name: .Services),
                generateDependency(name: .Resources),
                generateDependency(name: .Net),
                generateDependency(name: .DI),
                generateDependency(name: .Common),
                generateDependency(name: .CommonApplication)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.Auth.rawValue),
                .target(name: ProjectName.Auth.mockName),
                generateDependency(name: .CommonTest)
            ],
            doesUseSourcery: true
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.Auth.rawValue),
                generateDependency(name: .Common),
                generateDependency(name: .CommonApplication)
            ]
        ),
    ]
)
