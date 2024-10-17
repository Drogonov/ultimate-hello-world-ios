import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .MasterComponents,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
            ],
            dependencies: [
                .package(product: "SnapKit"),
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
