import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .CommonApplication,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                generateDependency(name: .CommonNet),
                generateDependency(name: .Common)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.CommonApplication.rawValue),
                .target(name: ProjectName.CommonApplication.mockName)
            ],
            doesUseSourcery: true
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.CommonApplication.rawValue),
            ]
        ),
    ]
)
