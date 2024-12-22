//
//  MagicPresenterTests.swift
//  MagicTests
//
//  Created by Anton Vlezko on 01/08/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import ServicesMocks
import Common
@testable import MagicMocks
@testable import Magic
import XCTest

// sourcery: AutoTestsMultiple
class MagicPresenterTests: XCTestCase {

    // sourcery:inline:MagicPresenterTests.TestsPropertyTemplate
    var presenter: MagicPresenter!
    var router: MagicRouterInputMock!
    var view: MagicViewInputMock!
    var appNetworkService: AppNetworkServiceProtocolMock!
    var languageService: LanguageChangeServiceProtocolMock!
    // sourcery:end

    override func setUp() {
        super.setUp()
        // sourcery:inline:MagicPresenterTests.TestsSetupTemplate
        router = .init()
        view = .init()
        appNetworkService = .init()
        languageService = .init()

        presenter = MagicPresenter(
            router: router
        )
        presenter.view = view
        presenter.appNetworkService = appNetworkService
        presenter.languageService = languageService
        // sourcery:end
    }

// sourcery:inline:auto:MagicPresenterTests.TestsOtherTemplate
    override func tearDown() {
        presenter = nil
        router = nil
        view = nil
        appNetworkService = nil
        languageService = nil
        super.tearDown()
    }
// sourcery:end
}

// sourcery:inline:MagicPresenterTests.TestsImpTemplate
// sourcery:end

// MARK: - MagicPresenterInput

extension MagicPresenterTests {

    func testViewIsReady() {
        // given
        // ...

        // when
//        presenter.viewIsReady()

        // then
        XCTAssertTrue(true)
    }

    func testViewWillAppear() {
        // given
        // ...

        // when
//        presenter.viewWillAppear()

        // then
        XCTAssertTrue(true)
    }

    func testViewWillDissapear() {
        // given
        // ...

        // when
//        presenter.viewWillDissapear()

        // then
        XCTAssertTrue(true)
    }

    func testViewNavigationItemBackAction() {
        // given
        // ...

        // when
        presenter.viewNavigationItemBackAction {}

        // then
        XCTAssertTrue(true)
    }

    func testViewButtonTapped() {
        // given
//        appNetworkService.getMagicDataRequestGetMagicRequestMoForceRequestBoolGetMagicResponseMoReturnValue =

        // when
//        presenter.viewButtonTapped()

        // then
        XCTAssertTrue(true)
    }
}
