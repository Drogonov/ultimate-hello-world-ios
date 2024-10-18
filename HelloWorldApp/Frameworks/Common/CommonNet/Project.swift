import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .CommonNet,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "ObjectMapper"),
                generateDependency(name: .Common)
            ]
        )
    ]
)
