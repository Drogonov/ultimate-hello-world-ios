import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .CommonTest,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.2.0"),
            ],
            dependencies: [
                .package(product: "ObjectMapper"),
                generateDependency(name: .CommonNet),
                .xctest
            ]
        )
    ]
)
