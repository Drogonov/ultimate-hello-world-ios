import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .MasterComponents,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "SnapKit"),
                generateDependency(name: .Resources),
                generateDependency(name: .CommonApplication),
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.MasterComponents.rawValue),
                .target(name: ProjectName.MasterComponents.mockName)
            ],
            doesUseSourcery: true
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.MasterComponents.rawValue),
            ]
        ),
    ]
)
