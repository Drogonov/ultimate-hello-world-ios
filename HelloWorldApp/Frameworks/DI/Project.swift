import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .DI,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "Swinject"),
            ]
        )
    ]
)
