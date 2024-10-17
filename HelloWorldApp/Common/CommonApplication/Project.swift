import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .CommonApplication,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0")
            ],
            dependencies: [
                .package(product: "ObjectMapper"),
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
