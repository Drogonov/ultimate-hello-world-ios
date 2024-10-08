//
//  ServiceConfigurator.swift
//  Services
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import DI
import Swinject
import Common
import Net
import CommonNet
import Persistence
import CommonApplication

public final class ServiceConfigurator: Assembly {

    public func assemble(container: Container) {
        registerNavigationStackService(in: container)
        registerFatallErrorWithTypeService(in: container)
        registerTypeCheckerService(in: container)
        registerSessionCacher(in: container)
        registerNetworkManager(in: container)
        registerModifier(in: container)
        registerBaseURLService(in: container)
        registerAppConfiguratorService(in: container)
        registerLanguageChangeService(in: container)
    }

    public init() {}
}

// MARK: - Private Methods

fileprivate extension ServiceConfigurator {
    func registerNavigationStackService(in container: Container) {
        container.register(NavigationStackServiceProtocol.self) { _ in
            NavigationStackService()
        }
        .implements(NavigationStackServiceProtocol.self, name: "common")
        .inObjectScope(.container)
    }

    func registerLanguageChangeService(in container: Container) {
        container.register(LanguageChangeServiceProtocol.self) { _ in
            LanguageChangeService()
        }
        .implements(LanguageChangeServiceProtocol.self)
    }

    func registerTypeCheckerService(in container: Container) {
        container.register(TypeCheckerServiceProtocol.self) { _ in
            TypeCheckerService()
        }
        .implements(TypeCheckerServiceProtocol.self)
    }

    func registerFatallErrorWithTypeService(in container: Container) {
        container.register(FatalErrorWithTypeServiceProtocol.self) { _ in
            FatalErrorWithTypeService()
        }
        .implements(FatalErrorWithTypeServiceProtocol.self)
    }

    func registerSessionCacher(in container: Container) {
        container.register(SessionCacher.self) { _ in
            SessionCacher()
        }
        .implements(CacheProtocol.self, name: CacherType.session)
        .inObjectScope(.container)
    }

    func registerNetworkManager(in container: Container) {
        container.register(NetworkManager.self) { _ in
            NetworkManager()
        }
        .initCompleted { resolver, manager in
            manager.modifier = resolver.resolve(NetModifierProtocol.self)
            manager.defaultHeaders = NetHeaders.defaultHeaders()
        }
        .implements(NetworkManagerProtocol.self, name: NetworkManagerType.main)
        .inObjectScope(.container)
    }

    func registerModifier(in container: Container) {
        container.register(NetModifier.self) { _ in
            NetModifier()
        }
        .initCompleted { resolver, instance in
            instance.appConfiguration = resolver.resolveSafe(AppConfigurationProtocol.self)
        }
        .implements(NetModifierProtocol.self)
    }

    func registerBaseURLService(in container: Container) {
        container.register(BaseURLServiceProtocol.self) { _ in
            BaseURLService()
        }
        .implements(BaseURLServiceProtocol.self)
    }

    func registerAppConfiguratorService(in container: Container) {
        container.register(AppConfigurationProtocol.self) { _ in
            AppConfiguration()
        }
    }
}
