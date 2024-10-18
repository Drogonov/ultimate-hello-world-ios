import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Common,
    targets: [
        TargetInfo(
            type: .plain
        )
    ]
)
