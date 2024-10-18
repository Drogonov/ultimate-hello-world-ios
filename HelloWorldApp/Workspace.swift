import ProjectDescription
import ProjectDescriptionHelpers

// https://github.com/tuist/tuist/tree/main/fixtures/ios_app_with_custom_scheme
//let customFrameworkScheme: Scheme = .scheme(
//    name: "Workspace-Framework",
//    shared: true,
//    buildAction: .buildAction(
//        targets: [
//            generateTargetReference(name: .CommonApplication)
//        ],
//        preActions: []
//    ),
//    testAction: TestAction
//        .targets([
//            .testableTarget(
//                target: generateTestTargetReference(name: .CommonApplication)
//            )
//        ]),
//    archiveAction: .archiveAction(configuration: "Debug", customArchiveName: "Something2")
//)

let workspace = Workspace(
    name: Constants.projectName,
    projects: [
        "App/**",
        "Frameworks/**"
    ]
)
