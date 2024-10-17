import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .Magic,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4")
            ],
            dependencies: [
                .package(product: "Swinject"),
                generateDependency(name: .Services),
                generateDependency(name: .Resources),
                generateDependency(name: .Net),
                generateDependency(name: .DI),
                generateDependency(name: .Common),
                generateDependency(name: .CommonApplication)
            ]
        ),
        TargetInfo(
            type: .test,
            dependencies: [
                .target(name: ProjectName.Magic.rawValue),
                .target(name: ProjectName.Magic.mockName),
                generateDependency(name: .CommonTest)
            ],
            doesUseSourcery: true
        ),
        TargetInfo(
            type: .mock,
            dependencies: [
                .target(name: ProjectName.Magic.rawValue),
                generateDependency(name: .Common),
                generateDependency(name: .CommonApplication)
            ]
        ),
    ]
)
