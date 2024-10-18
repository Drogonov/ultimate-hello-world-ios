import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Persistence,
    targets: [
        TargetInfo(
            type: .plain,
            dependencies: [
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                generateDependency(name: .CommonNet),
                generateDependency(name: .DI)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.Persistence.rawValue),
                .target(name: ProjectName.Persistence.mockName)
            ],
            doesUseSourcery: false
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.Persistence.rawValue),
            ]
        ),
    ]
)
