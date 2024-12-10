//
//  AppNetworkServiceTests.swift
//  Services
//
//  Created by Anton Vlezko on 06/10/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import PersistenceMocks
@testable import ServicesMocks
@testable import Services
import XCTest
import CommonNet
import CommonTest

// sourcery: AutoTestsMultiple
class AppNetworkServiceTests: XCTestCase {

    // sourcery:inline:AppNetworkServiceTests.TestsPropertyTemplate
    var service: AppNetworkService!
    var api: AppAPIProtocolMock!
    var shortCacher: CacheProtocolMock!
    // sourcery:end

    override func setUp() {
        super.setUp()
        // sourcery:inline:AppNetworkServiceTests.TestsSetupTemplate
        api = .init()
        shortCacher = .init()

        service = AppNetworkService(
            api: api,
            shortCacher: shortCacher
        )
        // sourcery:end
    }

// sourcery:inline:auto:AppNetworkServiceTests.TestsOtherTemplate
    override func tearDown() {
        service = nil
        api = nil
        shortCacher = nil
        super.tearDown()
    }
// sourcery:end
}

// MARK: - AppNetworkServiceProtocol

extension AppNetworkServiceTests {

    func testGetMoreInfoData() async {
        // given
        let request: GetMoreInfoRequestMo = .init(languageCode: "en")
        let forceRequest = true
        let response = loadObjectFromJson(GetMoreInfoResponseMo.self, filename: "getMoreInfoService_success_en")

        api.getMoreInfoDataRequestGetMoreInfoRequestMoGetMoreInfoResponseMoReturnValue = response

        // when
        let result = try? await service.getMoreInfoData(request: request, forceRequest: forceRequest)

        // then
        XCTAssertNotNil(result)
    }

    func testGetMagicData() async {
        // given
        let request: GetMagicRequestMo = .init(languageCode: "en")
        let forceRequest = true
        let response = loadObjectFromJson(GetMagicResponseMo.self, filename: "getMagicService_success_en")

        api.getMagicDataRequestGetMagicRequestMoGetMagicResponseMoReturnValue = response

        // when
        let result = try? await service.getMagicData(request: request, forceRequest: forceRequest)

        // then
        XCTAssertNotNil(result)
    }

    func testGetHelloData() async {
        // given
        let request: GetHelloRequestMo = .init(languageCode: "en")
        let forceRequest = true
        let response = loadObjectFromJson(GetHelloResponseMo.self, filename: "getHelloService_success_en")

        api.getHelloDataRequestGetHelloRequestMoGetHelloResponseMoReturnValue = response

        // when
        let result = try? await service.getHelloData(request: request, forceRequest: forceRequest)

        // then
        XCTAssertNotNil(result)
    }

    func testGetCountriesData() async {
        // given
        let request: GetCountriesRequestMo = .init(languageCode: "en")
        let forceRequest = true
        let response = loadObjectFromJson(GetCountriesResponseMo.self, filename: "getCountriesService_success_en")

        api.getCountriesDataRequestGetCountriesRequestMoGetCountriesResponseMoReturnValue = response

        // when
        let result = try? await service.getCountriesData(request: request, forceRequest: forceRequest)

        // then
        XCTAssertNotNil(result)
    }
}

// sourcery:inline:AppNetworkServiceTests.TestsImpTemplate
// sourcery:end
