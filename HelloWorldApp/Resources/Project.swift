import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Resources,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                generateDependency(name: .Common)
            ],
            doesIncludeResources: true
        )
    ]
)
