/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 
In accordance with Sections 4 and 6 of the License, the following exclusions apply:

    1. Trademarks & Logos – The names, logos, and trademarks of the Licensor are not covered by this License and may not be used without separate permission.
    2. Design Rights – Visual identities, UI/UX designs, and other graphical elements remain the property of their respective owners and are not licensed under the Apache License 2.0.
    3: Non-Coded Copyrights – Documentation, images, videos, and other non-software materials require separate authorization for use, modification, or distribution.

These elements are not considered part of the licensed Work or Derivative Works unless explicitly agreed otherwise. All elements must be altered, removed, or replaced before use or distribution. All rights to these materials are reserved, and Contributor accepts no liability for any infringing use. By using this repository, you agree to indemnify and hold harmless Contributor against any claims, costs, or damages arising from your use of the excluded elements.

SPDX-FileCopyrightText: 2025 Deutsche Telekom AG
SPDX-License-Identifier: Apache-2.0 AND LicenseRef-Deutsche-Telekom-Brand
License-Filename: LICENSES/Apache-2.0.txt LICENSES/LicenseRef-Deutsche-Telekom-Brand.txt
*///
//  SCDashboardViewControllerTests.swift
//  OSCATests
//
//  Created by Bhaskar N S on 10/06/22.
//  Copyright © 2022 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import XCTest
@testable import OSCA

class SCDashboardViewControllerTests: XCTestCase {

    private func prepareSut() -> SCDashboardViewController {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "SCDashboardViewController") as! SCDashboardViewController
        sut.presenter = SCDashboardPresenterMock()
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testViewDidLoad() {
        let sut = prepareSut()
        sut.viewDidLoad()
        guard let presenter = sut.presenter as? SCDashboardPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isViewDidLoadCalled)
    }
    
    func testViewWillAppear() {
        let sut = prepareSut()
        sut.viewWillAppear(true)
        guard let presenter = sut.presenter as? SCDashboardPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isViewWillAppearCalled)
    }
    
    func testViewDidAppear() {
        let sut = prepareSut()
        sut.viewDidAppear(true)
        guard let presenter = sut.presenter as? SCDashboardPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isViewDidAppearCalled)
    }
    
    func testDidSelectListItem() {
        let sut = prepareSut()
        sut.viewDidLoad()
        let newsItem = SCBaseComponentItem(itemID: "123", itemTitle: "abc", itemHtmlDetail: true, itemColor: UIColor.blue)
        sut.didSelectListItem(item: newsItem)
        guard let presenter = sut.presenter as? SCDashboardPresenterMock,
              let news = presenter.selectedNewsItem else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertEqual(news, newsItem)
    }
    
    func testSetCoatOfArmsImageURL() {
        let url = SCImageURL(urlString: "/img/Bad-Honnef-Logo.jpg", persistence: true)
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.setCoatOfArmsImageURL(url)
    }
    
    func testUpdateWeather() {
        var info: String = "broken clouds, 21°"
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.setWeatherInfo(info)
        XCTAssertEqual(sut.headerWeatherLabel.text, info)
    }
    
    func testSetWelcomeText() {
        let mockMsg = LocalizationKeys.SCDashboardPresenter.h001HomeTitlePart.localized()
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.setWelcomeText(mockMsg)
        XCTAssertEqual(sut.headerWelcomeLabel.text, mockMsg)
    }
    
    func testSetCityName() {
        let sut = prepareSut()
        sut.viewDidLoad()
        let mockCityName = "Bad Honnef"
        sut.setCityName(mockCityName)
        XCTAssertEqual(mockCityName, sut.headerCityLabel.text)
    }
    
    func testUpdateNews() {
        let sut = prepareSut()
        sut.viewDidLoad()
        let mockFlags = SCDashboardFlags(showTips: true, showOffers: true, showDiscounts: false)
        let mockNews = [SCBaseComponentItem(itemID: "123", itemTitle: "abc", itemHtmlDetail: true, itemColor: UIColor.blue),
                        SCBaseComponentItem(itemID: "345", itemTitle: "pqr", itemHtmlDetail: true, itemColor: UIColor.blue),
                        SCBaseComponentItem(itemID: "567", itemTitle: "zyc", itemHtmlDetail: true, itemColor: UIColor.blue)]
        sut.updateNews(with: mockNews)
        XCTAssertEqual(sut.presenter.getDashboardFlags(), mockFlags)
    }
    
    func testDidSelectCarouselItem() {
        let sut = prepareSut()
        sut.viewDidLoad()
        let newsItem = SCBaseComponentItem(itemID: "123", itemTitle: "abc", itemHtmlDetail: true, itemColor: UIColor.blue)
        sut.didSelectCarouselItem(item: newsItem)
        guard let presenter = sut.presenter as? SCDashboardPresenterMock,
              let news = presenter.selectedNewsItem else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertEqual(news, newsItem)
    }
    
    func testSelectListEventItem() {
        let sut = prepareSut()
        sut.viewDidLoad()
        let item = SCModelEvent(description: "", endDate: "",
                                    startDate: "", hasEndTime: true, hasStartTime: true, imageURL: SCImageURL(urlString: "", persistence: false),
                                    thumbnailURL: nil, latitude: 1.0, longitude: 1.0, locationName: "",
                                    locationAddress: "", subtitle: "", title: "", imageCredit: "",
                                    thumbnailCredit: "", pdf: nil, uid: "", link: "", categoryDescription: "",
                                    status: nil)
        sut.didSelectListEventItem(item: item)
        guard let presenter = sut.presenter as? SCDashboardPresenterMock,
              let eventItem = presenter.item else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertEqual(eventItem, item)
    }
    
    func testBarBtnProfilenWasPressed() {
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.barBtnProfilenWasPressed("")
        guard let presenter = sut.presenter as? SCDashboardPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.wasProfileBtnTapped)
    }
    
    func testBarBtnGeoLocationWasPressed() {
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.barBtnGeoLocationWasPressed("")
        guard let presenter = sut.presenter as? SCDashboardPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.geoLocationWasPressed)
    }
    
    func testShowChangeLocationToolTip() {
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.showChangeLocationToolTip()
    }
    
    func testHandleRefresh() {
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.handleRefresh(UIRefreshControl())
        guard let presenter = sut.presenter as? SCDashboardPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.needsToReloadDataCalled)
    }
    
    func testResetUI() {
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.resetUI()
        XCTAssertTrue(sut.shouldNavBarTransparent)
    }
    
}

//class SCDashboardPresenterMock: SCPresenting, SCDashboardPresenting {
//    
//    private(set) var isViewDidLoadCalled: Bool = false
//    private(set) var isViewDidAppearCalled: Bool = false
//    private(set) var isViewWillAppearCalled: Bool = false
//    private(set) var cityName: String = ""
//    private(set) var selectedNewsItem: SCBaseComponentItem?
//    private(set) var item: SCModelEvent?
//    private(set) var wasProfileBtnTapped: Bool = false
//    private(set) var geoLocationWasPressed: Bool = false
//    private(set) var needsToReloadDataCalled: Bool = false
//    
//    func setDisplay(_ display: SCDashboardDisplaying) {
//        
//    }
//    
//    func didSelectCarouselItem(item: SCBaseComponentItem) {
//        selectedNewsItem = item
//    }
//    
//    func didSelectListItem(item: SCBaseComponentItem) {
//        self.selectedNewsItem = item
//    }
//    
//    func didSelectListEventItem(item: SCModelEvent) {
//        self.item = item
//    }
//    
//    func didPressMoreNewsBtn() {
//        
//    }
//    
//    func didPressMoreEventsBtn() {
//        
//    }
//    
//    func locationButtonWasPressed() {
//        geoLocationWasPressed = true
//    }
//    
//    func profileButtonWasPressed() {
//        wasProfileBtnTapped = true
//    }
//    
//    func getDashboardFlags() -> SCDashboardFlags {
//        return SCDashboardFlags(showTips: true, showOffers: true, showDiscounts: false)
//    }
//    
//    func needsToReloadData() {
//        needsToReloadDataCalled = true
//    }
//    
//    func viewDidLoad() {
//        isViewDidLoadCalled = true
//    }
//    
//    func viewWillAppear() {
//        isViewWillAppearCalled = true
//    }
//    
//    func viewDidAppear() {
//        isViewDidAppearCalled = true
//    }
//    
//    
//}
