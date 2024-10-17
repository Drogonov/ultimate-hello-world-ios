import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: ProjectName.HellowWorldApp.rawValue,
    organizationName: Constants.organisationName,
    targets: [
        .target(
            name: ProjectName.HellowWorldApp.rawValue,
            destinations: .iOS,
            product: .app,
            bundleId: Constants.rootBundleId,
            infoPlist: "Sources/Supporting Files/Info.plist",
            sources: ["Sources/**"],
            entitlements: "Sources/Supporting Files/HelloWorldApp.entitlements",
            dependencies: [
                .external(name: "ObjectMapper"),
                .external(name: "SnapKit"),
                .external(name: "Swinject"),
                .external(name: "RealmSwift"),
                generateDependency(name: .DI),
                generateDependency(name: .Resources),
                generateDependency(name: .MasterComponents),
                generateDependency(name: .Persistence),
                generateDependency(name: .Net),
                generateDependency(name: .Services),
                generateDependency(name: .Deeplinks),
                generateDependency(name: .HelloWorld),
                generateDependency(name: .Magic),
                generateDependency(name: .Common),
                generateDependency(name: .CommonNet),
                generateDependency(name: .CommonApplication),
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_ENTITLEMENTS": "Sources/Supporting Files/HelloWorldApp.entitlements"
                ]
            )
        ),
        .target(
            name: ProjectName.HellowWorldApp.testName,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(Constants.rootBundleId)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: ProjectName.HellowWorldApp.rawValue)
            ]
        )
    ]
    // # TODO: Add target for proper tests of the app
//    schemes: [
//        .scheme(
//            name: "HelloWorldAppTests",
//            shared: true,
//            buildAction: .buildAction(targets: [
//                .project(
//                    path: Path(stringLiteral: ProjectName.HellowWorldApp.rawValue),
//                    target: ProjectName.HellowWorldApp.rawValue
//                ),
//                .project(
//                    path: Path(stringLiteral: ProjectName.CommonApplication.path),
//                    target: ProjectName.CommonApplication.rawValue
//                ),
//                // Add build targets here if necessary
//            ]),
//            testAction: .targets([
//                .testableTarget(target: .project(
//                    path: Path(stringLiteral: ProjectName.HellowWorldApp.rawValue),
//                    target: ProjectName.HellowWorldApp.testName
//                )),
//                .testableTarget(target: .project(
//                    path: Path(stringLiteral: ProjectName.CommonApplication.rawValue),
//                    target: ProjectName.CommonApplication.testName
//                ))
//            ])
//        )
//    ]
)

