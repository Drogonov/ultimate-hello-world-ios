import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .CommonTest,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "ObjectMapper"),
                generateDependency(name: .CommonNet),
                .xctest
            ]
        )
    ]
)
