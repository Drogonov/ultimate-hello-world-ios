//
//  InitDeeplinksCommand.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 26/07/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import Swinject

final public class InitDeeplinksCommand: Command {

    public init() {}

    public func execute() {
        let handlers = [
            MagicDeeplinkHandler()
        ]

        var iterator = handlers.dropFirst().makeIterator()

        handlers.forEach {
            $0.next = iterator.next()
        }

        if let handler = handlers.first {
            DeeplinksManager.shared.register(handler: handler)
        }

        DIAssembler.apply([
            DeeplinkConfigurator()
        ])
    }
}

public final class DeeplinkConfigurator: Assembly {

    public func assemble(container: Container) {
        registerDeeplLinkService(in: container)
    }

    public init() {}
}

// MARK: - Private Methods

fileprivate extension DeeplinkConfigurator {
    func registerDeeplLinkService(in container: Container) {
        container.register(DeeplinksServiceProtocol.self) { _ in
            DeeplinksService()
        }
        .implements(DeeplinksServiceProtocol.self)
    }
}

