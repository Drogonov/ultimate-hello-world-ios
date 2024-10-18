import ProjectDescription
import ProjectDescriptionHelpers

// https://github.com/tuist/tuist/tree/main/fixtures/ios_app_with_custom_scheme
let customFrameworkScheme: Scheme = .scheme(
    name: "\(Constants.projectName)-Debug",
    shared: true,
    buildAction: .buildAction(
        targets: generateTargetsReferences(names: ProjectName.allCases),
        preActions: []
    ),
    testAction: .targets(
        generateTestableTargetsReferences(names: [
            .App,
            .CommonApplication,
            .MasterComponents,
            .Persistence,
            .Deeplinks,
            .Services,
            .HelloWorld,
            .Magic
        ])
    ),
    runAction: .runAction(
        executable: generateTargetReference(name: .App)
    ),
    archiveAction: .archiveAction(configuration: "Debug", customArchiveName: "Debug")
)

let workspace = Workspace(
    name: Constants.projectName,
    projects: [
        "App/**",
        "Frameworks/**"
    ],
    schemes: [customFrameworkScheme]
)
