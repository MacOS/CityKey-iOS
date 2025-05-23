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
//  SCDatePickerPreseenterTests.swift
//  SmartCityTests
//
//  Created by Michael on 22.10.19.
//  Copyright © 2019 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import XCTest
@testable import OSCA

class SCDatePickerPreseenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHashing() {
        let presenter = SCDatePickerPresenter(injector: MockAdjustTrackingInjector(), todayDate: dateFromString(dateString: "2019-08-01 00-00-00")!, maxMonth: 13, preSelectedStartDate: nil, preSelectedEndDate: nil)
        presenter.reloadData(dateFromString(dateString: "2019-08-01 00-00-00")!)

        let hash = Date.hashForDate(presenter.todayDate)
        let date = Date.dateFromHash(hash)
        
        XCTAssert(hash == 20190801)
        XCTAssert(date == presenter.todayDate)
    }

    func testDateOfMonth() {
        let presenter = SCDatePickerPresenter(injector: MockAdjustTrackingInjector(), todayDate: dateFromString(dateString: "2019-08-01 00-00-00")!, maxMonth: 13, preSelectedStartDate: nil, preSelectedEndDate: nil)
        presenter.reloadData(dateFromString(dateString: "2019-08-01 00-00-00")!)

        let days = presenter.getDaysOfMonth(8, year: 2019, todayDate: dateFromString(dateString: "2019-08-01 00-00-00")!)

        let day = presenter.day(for: 0, dayIndex: 10)
        XCTAssert(days[10].dayValue == 20190808)
        XCTAssert(days[30].dayValue == 20190828)
        XCTAssert(day.dayValue == 20190808)
        print(day)
        
    }

    func testDateSelection(){
        let presenter = SCDatePickerPresenter(injector: MockAdjustTrackingInjector(), todayDate: dateFromString(dateString: "2019-08-05 00-00-00")!, maxMonth: 13, preSelectedStartDate: dateFromString(dateString: "2019-08-08 00-00-00")!, preSelectedEndDate: dateFromString(dateString: "2019-08-14 00-00-00")!)
        
        presenter.viewDidLoad()
        presenter.reloadData(dateFromString(dateString: "2019-08-01 00-00-00")!)
        
        let numberOfMonthInDatePicker = presenter.numberOfMonthInDatePicker()
        let numberOfDaysForMonthIndex = presenter.numberOfDaysForMonthIndex(monthIndex: 0)

        XCTAssert(numberOfMonthInDatePicker == 13)
        XCTAssert(numberOfDaysForMonthIndex == 35)

        let isDaySelectableWrong = presenter.isDaySelectable(SCDatePickerDay(dayString: "03", dayValue: 20190803, type: .past))
        let isDaySelectableCorrect = presenter.isDaySelectable(SCDatePickerDay(dayString: "30", dayValue: 20190830, type: .futureWorkday))

        XCTAssert(isDaySelectableWrong == false)
        XCTAssert(isDaySelectableCorrect == true)

        let isDaySelectedWrong = presenter.isDaySelectable(SCDatePickerDay(dayString: "03", dayValue: 20190803, type: .past))
        let isDaySelectedCorrect = presenter.isDaySelectable(SCDatePickerDay(dayString: "11", dayValue: 20190811, type: .futureWorkday))

        XCTAssert(isDaySelectedWrong == false)
        XCTAssert(isDaySelectedCorrect == true)

        SCUtilities.delay(withTime: 0.0, callback: {
            let isFirstDayOfSelectionWrong = presenter.isFirstDayOfSelection(SCDatePickerDay(dayString: "09", dayValue: 20190809, type: .futureWorkday))
            let isFirstDayOfSelectionCorrect = presenter.isFirstDayOfSelection(SCDatePickerDay(dayString: "08", dayValue: 20190808, type: .futureWorkday))

            XCTAssert(isFirstDayOfSelectionWrong == false)
            XCTAssert(isFirstDayOfSelectionCorrect == true)

            let isLastDayOfSelectionWrong = presenter.isLastDayOfSelection(SCDatePickerDay(dayString: "16", dayValue: 20190816, type: .futureWorkday))
            let isLastDayOfSelectionCorrect = presenter.isLastDayOfSelection(SCDatePickerDay(dayString: "14", dayValue: 20190814, type: .futureWorkday))

            XCTAssert(isLastDayOfSelectionWrong == false)
            XCTAssert(isLastDayOfSelectionCorrect == true)
        })
    }
}

private class MockAdjustTrackingInjector: SCAdjustTrackingInjection {
    func trackEvent(eventName: String) {
        return
    }
    
    func trackEvent(eventName: String, parameters: [String : String]) {
    }

    func appWillOpen(url: URL) {
        return
    }
}

