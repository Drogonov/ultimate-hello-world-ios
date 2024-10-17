import ProjectDescription
import ProjectDescriptionHelpers

let project = generateProject(
    projectName: .DI,
    targets: [
        TargetInfo(
            type: .plain,
            packages: [
                .package(url: "https://github.com/Swinject/Swinject", from: "2.8.4"),
            ],
            dependencies: [
                .package(product: "Swinject")
            ]
        )
    ]
)
