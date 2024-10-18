import ProjectDescription
import ProjectDescriptionHelpers

// https://github.com/tuist/tuist/tree/main/fixtures/ios_app_with_custom_scheme
let customFrameworkScheme: Scheme = .scheme(
    name: "Workspace-Framework",
    shared: true,
    buildAction: .buildAction(
        targets: [
            .project(path: "App", target: "App")
        ],
        preActions: []
    ),
    testAction: .targets([
        .testableTarget(
            target: .project(path: "App", target: "AppTests")
        )
    ]),
    runAction: .runAction(executable: .project(path: "App", target: "App")),
    archiveAction: .archiveAction(configuration: "Debug", customArchiveName: "Something2")
)

let workspace = Workspace(
    name: Constants.projectName,
    projects: [
        "App/**",
        "Frameworks/**"
    ],
    schemes: [customFrameworkScheme]
)
