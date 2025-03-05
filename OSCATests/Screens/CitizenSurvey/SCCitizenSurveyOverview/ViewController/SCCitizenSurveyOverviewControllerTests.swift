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
//  SCCitizenSurveyOverviewControllerTests.swift
//  OSCATests
//
//  Created by Bhaskar N S on 20/09/22.
//  Copyright © 2022 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import XCTest
@testable import OSCA


final class SCCitizenSurveyOverviewControllerTests: XCTestCase {
    
    private func prepareSut(presenter: SCCitizenSurveyOverviewPresenting? = nil) -> SCCitizenSurveyOverviewController {
        let storyboard = UIStoryboard(name: "CitizenSurvey", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "SCCitizenSurveyOverviewController") as! SCCitizenSurveyOverviewController
        sut.presenter = presenter ?? SCCitizenSurveyOverviewPresenterMock(surveyOverview: getSurveyOverview())
        sut.loadViewIfNeeded()
        return sut
    }
    
    private func getSurveyOverview() -> SCModelCitizenSurveyOverview {
        SCModelCitizenSurveyOverview(isDpAccepted: true, id: 12, name: "TestSurvey", description: "TestSurveyDescription",
                                                  startDate: Date(), endDate: Date(), isPopular: true,
                                                  status: .inProgress, dataProtectionText: "", isClosed: false,
                                                  totalQuestions: 3, attemptedQuestions: 1, daysLeft: 3)
    }
    
    func testViewDidLoad() {
        let mockNavTitle = LocalizationKeys.SCCitizenSurveyOverviewViewController.cs002PageTitle.localized()
        let presenter = SCCitizenSurveyOverviewPresenterMock(surveyOverview: getSurveyOverview())
        let sut = prepareSut(presenter: presenter)
        sut.viewDidLoad()
        XCTAssertTrue(presenter.isViewDidLoadCalled)
        XCTAssertEqual(sut.navigationItem.title, mockNavTitle)
    }
    
    func testUpdateSurveyList() {
        let presenter = SCCitizenSurveyOverviewPresenterMock(surveyOverview: getSurveyOverview())
        let sut = prepareSut(presenter: presenter)
        sut.updateSurveyList()
        XCTAssertTrue(presenter.isFetchCalled)
    }
    
    func testSelected() {
        let presenter = SCCitizenSurveyOverviewPresenterMock(surveyOverview: getSurveyOverview())
        let sut = prepareSut(presenter: presenter)
        sut.selected(survey: getSurveyOverview())
        XCTAssertTrue(presenter.displaySurveyDetailsCalled)
    }
    
    
}

final class SCCitizenSurveyOverviewPresenterMock: SCCitizenSurveyOverviewPresenting {
    let surveyOverview: SCModelCitizenSurveyOverview
    private(set) var isViewDidLoadCalled: Bool = false
    private(set) var isFetchCalled: Bool = false
    private(set) var displaySurveyDetailsCalled: Bool = false
    init(surveyOverview: SCModelCitizenSurveyOverview) {
        self.surveyOverview = surveyOverview
    }
    
    func viewDidLoad() {
        isViewDidLoadCalled = true
        
    }
    
    func set(display: OSCA.SCCitizenSurveyOverviewDisplaying) {
        
    }
    
    func getSurveyList() -> [OSCA.SCModelCitizenSurveyOverview] {
        [surveyOverview]
    }
    
    func displaySurveyDetails(survey: OSCA.SCModelCitizenSurveyOverview) {
        displaySurveyDetailsCalled = true
    }
    
    func fetchSurveyList() {
        isFetchCalled = true
    }
}
