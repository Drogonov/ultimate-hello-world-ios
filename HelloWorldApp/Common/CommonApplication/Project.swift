import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .CommonApplication,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "ObjectMapper"),
                generateDependency(name: .DI),
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
