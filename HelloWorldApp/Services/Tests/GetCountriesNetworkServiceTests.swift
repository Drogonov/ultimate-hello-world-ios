//
//  GetCountriesNetworkServiceTests.swift
//  Services
//
//  Created by Anton Vlezko on 06/10/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import PersistenceMocks
@testable import ServicesMocks
@testable import Services
import XCTest

// sourcery: AutoTestsMultiple
class GetCountriesNetworkServiceTests: XCTestCase {

    // sourcery:inline:GetCountriesNetworkServiceTests.TestsPropertyTemplate
    var service: GetCountriesNetworkService!
    var api: GetCountriesAPIProtocolMock!
    var shortCacher: CacheProtocolMock!
    // sourcery:end

    override func setUp() {
        super.setUp()
        // sourcery:inline:GetCountriesNetworkServiceTests.TestsSetupTemplate
        api = .init()
        shortCacher = .init()

        service = GetCountriesNetworkService(
            api: api,
            shortCacher: shortCacher
        )
        // sourcery:end
    }

// sourcery:inline:auto:GetCountriesNetworkServiceTests.TestsOtherTemplate
    override func tearDown() {
        service = nil
        api = nil
        shortCacher = nil
        super.tearDown()
    }
// sourcery:end
}
// sourcery:inline:GetCountriesNetworkServiceTests.TestsImpTemplate
// sourcery:end

// MARK: - GetCountriesNetworkServiceProtocol

extension GetCountriesNetworkServiceTests {

    func testGetCountriesData() {
        // given
        // TODO: add functionality to load objects from JSONs
//        let request =
        let forceRequest = true

        // when
//        let result = service.getCountriesData(request: request, forceRequest: forceRequest)

        // then
        XCTAssertTrue(true)
    }
}
