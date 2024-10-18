import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Net,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "ObjectMapper"),
                generateDependency(name: .MasterComponents),
                generateDependency(name: .Persistence),
                generateDependency(name: .CommonNet)
            ]
        )
    ]
)
