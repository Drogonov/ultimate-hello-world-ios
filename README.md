# ultimate-hello-world-ios [![License](https://img.shields.io/badge/License-MIT-red)](License) ![Platform](https://img.shields.io/badge/Platform-iOS-red) ![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)

_An ultimate way to say Hello to the World in the production manner!_

## Purpose?

It is simple **MVP+R** architecture app with a few SwiftUI screens and two distinct flows. It incorporates common features required for medium-sized applications, which can be difficult to retrofit after a significant amount of code has already been written.

**So let's implement them upfront!**

## Key features

- **Modularity** - will help us with testing and developing features without unexpected influence on other parts of the app. Here we will use [Tuist](https://docs.tuist.io).

- **Deeplinking** - enables routing between flows in the app or opening flows from external apps.

- **DI** - without [Swinject](https://github.com/Swinject), we can't develop a modular and testable app.

- **Xcode Templates** - will increase the speed of development and provide a living example of our code style.

- **Network Layer on Async Await** - a fast network layer with [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper) to access all levels of abstraction, handle errors, and manage our server connection.

- **Short Caching** - an easy way to transfer information between modules.

- **Code-generated Mocks, Tests, and Resources** - with [SwiftGen](https://github.com/SwiftGen) from [Tuist](https://docs.tuist.io) and [Sourcery](https://github.com/krzysztofzablocki/Sourcery), we will decrease the amount of written code and generate boilerplate code for tests and strings.

- **Multiple Languages** - it is a headache to insert this feature into a monolingual app, so it's better to set up all infrastructure before we have thousands of strings.

- **Mocks in Mockoon for local backend tests** - will speed up our development. With [Mockoon](https://github.com/mockoon), you can forget about swizzling backend responses in Proxyman. Just you, predictable JSONs, and your app.

- **SwiftUI views in MVP+R architecture** - SwiftUI is the path along which Apple will lead us. However, it is still hard to handle deeplinks and a lot of functionalities in pure SwiftUI. Let's try to take the best from UIKit and SwiftUI and make a good app. And use a little bit [SnapKit](https://github.com/SnapKit/SnapKit).

## How to Start?

### 1. Mockoon

- [Download Mockoon](https://github.com/mockoon)
- Install Mockoon
- Open Mockoon App and open new local envoironment at path

```
<your_root_dir>/ultimate-hello-world-ios/Mockoon/HelloWorld.json
```
- Press start server button in Mockoon

### 2. Build the App

- [Install Tuist](https://docs.tuist.io/guides/quick-start/install-tuist) version 4.20 or above
- Open in terminal root app folder

```
<your_root_dir>/ultimate-hello-world-ios/HelloWorldApp
```
- Install dependencies and generate project with tuist

```
tuist install && tuist generate
```
- When project will be generated Xcode will be opened and you can start testing app!

### 3. Install Templates

- Start in terminal script to install Templates

```
sh <your_root_dir>/ultimate-hello-world-ios/Templates/install-swifty-mvp-xcode-templates.sh
```
- If you will add any changes to Tempates pls add new version to version.txt and run script one more time

### How to Test?

- Change target to HelloWorldApp-Workspace and press 
- If you will have problems pls try to build CommonApplication tests directly by changing target to it and pressing _Cmd+U_ (this problems is already in _TODOs_)

## Project Targets Description

- **HelloWorldApp** - The main application target, containing the app's primary functionality and UI components.

- **DI** - Manages dependency injection for the app, enabling the separation of concerns and improving testability.

- **Resources** - Handles asset and resource management, ensuring efficient access and organization of images, localizations, and other resources.

- **MasterComponents** - Houses shared UI and non-UI components that can be reused across different parts of the app.

- **Persistence** - Manages data storage and retrieval, ensuring efficient and reliable data handling.

- **Net** - Handles network operations, providing a robust interface for making network requests and managing responses.

- **Services** - Contains service layer implementations, which provide business logic and interact with the data layer.

- **Deeplinks** - Manages deeplink handling and routing within the app, allowing for seamless flow transitions and external app access.

- **HelloWorld** - A module containing specific functionality and UI elements related to the "HelloWorld" feature.

- **Magic** - A module containing specific functionality and UI elements related to the "Magic" feature.

- **Common** - Contains shared code that can be used by multiple modules to reduce redundancy.

- **CommonNet** - Consists of common networking utilities and components shared across the application's network layer.

- **CommonUI** - Provides shared UI components and styles, standardizing the app's visual design.

- **CommonApplication** - Contains code shared across multiple application modules, ensuring consistency and efficiency.

## License

[ultimate-hello-world-ios](https://github.com/Drogonov/ultimate-hello-world-ios) is created by [Anton Vlezko](https://github.com/Drogonov) and released under a [MIT License](License).

## TODOs
- Add gifs to readme
- Implement [TODO to Issue](https://github.com/marketplace/actions/todo-to-issue)
