/*
Created by Rutvik Kanbargi on 22/07/20.
Copyright © 2020 Deutsche Telekom AG - VTI Organization. All rights reserved.

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

SPDX-FileCopyrightText: 2025 Deutsche Telekom AG, Rutvik Kanbargi
SPDX-License-Identifier: Apache-2.0 AND LicenseRef-Deutsche-Telekom-Brand
License-Filename: LICENSES/Apache-2.0.txt LICENSES/LicenseRef-Deutsche-Telekom-Brand.txt
*/

import Foundation
import UIKit

protocol SCServiceDetailPresenting: SCPresenting {
    func showBadgeCount()
    func setDisplay(_ display: SCServiceDetailDisplaying)
    func getServiceTitle() -> String?
    func getBadgeDescriptionText() -> String?
    func getButtonText() -> String
    func getServiceImage() -> SCImageURL?
    func getServiceDetails() -> String?
    func displayServiceOverviewPage()
    func displayServicePage()
    func displayWasteCalendarViewController(items: [SCModelWasteCalendarItem], address: SCModelWasteCalendarAddress, wasteReminders: [SCHttpModelWasteReminder])
    func displayServiceStatusPage()
    func isShowServiceStatusButton() -> Bool
    func getSecondaryButtonText() -> String?
}

class SCServiceDetailPresenter {

    weak private var display: SCServiceDetailDisplaying?

    private let userCityContentSharedWorker: SCUserCityContentSharedWorking
    private let injector: SCServicesInjecting
    private let serviceData: SCBaseComponentItem
    private let displayServicePageDirectly: Bool

    private let serviceDetail: SCServiceDetailProvider
    var wasateCalendarMonth: String?
    private var isDisplayOverviewScreen: Bool = false

    init(userCityContentSharedWorker: SCUserCityContentSharedWorking,
         injector: SCServicesInjecting,
         serviceData: SCBaseComponentItem,
         serviceDetail: SCServiceDetailProvider,
         displayServicePageDirectly: Bool,
         isDisplayOverviewScreen: Bool = false) {
        self.userCityContentSharedWorker = userCityContentSharedWorker
        self.injector = injector
        self.serviceData = serviceData
        self.serviceDetail = serviceDetail
        self.displayServicePageDirectly = displayServicePageDirectly
        self.isDisplayOverviewScreen = isDisplayOverviewScreen
        setupNotifications()
    }

    private func setupNotifications() {
        SCDataUIEvents.registerNotifications(for: self,
                                             on: .didChangeAppointmentsDataState,
                                             with: #selector(didReceiveAppointmetsData))
    }

    deinit {
        SCDataUIEvents.discardNotifications(for: self)
    }

    @objc private func didReceiveAppointmetsData() {
        displayBadgeCount()
    }

    private func displayBadgeCount() {
        display?.showBadge(count: serviceDetail.getBadgeCount())
    }
}

extension SCServiceDetailPresenter: SCServiceDetailPresenting {

    func setDisplay(_ display: SCServiceDetailDisplaying) {
        self.display = display
    }

    func getServiceTitle() -> String? {
        return serviceData.itemTitle
    }

    func getBadgeDescriptionText() -> String? {
        return serviceDetail.getBadgeDescriptionText()
    }
    
    func getButtonText() -> String {
        return serviceDetail.getButtonText()
    }

    func getServiceImage() -> SCImageURL? {
        return (serviceData.headerImageURL == nil) ? serviceData.itemImageURL : serviceData.headerImageURL
    }

    func showBadgeCount() {
        displayBadgeCount()
    }

    
/// bugfix/SMARTC_18941_PPD_Final_remove_email_link - commented the current implementation and added below method with two additional methods for this story
/// This will not be needed in future once we have the email links working on iOS
    
//    func getServiceDetails() -> NSMutableAttributedString? {
//        if let attrString =  serviceData.itemDetail?.htmlAttributedString?.trimmedAttributedString(set: .whitespacesAndNewlines) {
//            let htmlAttributedString = NSMutableAttributedString(attributedString: attrString)
//            htmlAttributedString.replaceFont(with: UIFont.systemFont(ofSize: (UIScreen.main.bounds.size.width) == 320 ? 14.0 : 16.0, weight: UIFont.Weight.medium), color: UIColor(named: "CLR_LABEL_TEXT_BLACK")!)
//            return htmlAttributedString
//        }
//        return nil
//    }

    func getServiceDetails() -> String? {
        return serviceData.itemDetail
    }

    private func removeEmailLink(input : String) -> String {

        guard SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: "14.6") else {
            return input
        }
        
        var detailsString = input
        let range1 = detailsString.range(of: "<a href=\"mailto")
        let range2 = detailsString.range(of: "</a>")
        if let startIndex = range1?.lowerBound, let endIndex = range2?.upperBound {
            let range = startIndex..<endIndex
            detailsString.removeSubrange(range)
        }
        return detailsString
    }
    
    private func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric, range: nil, locale: nil) != .orderedAscending
    }
    
    func displayServiceOverviewPage() {
        // HARSHADA TODO - uncomment this check if we want to show more info button with no user action in defect reporter
//        if serviceData.itemFunction != "mängelmelder"{
//            display?.push(viewController: serviceDetail.getPushController())
//        }
        display?.push(viewController: serviceDetail.getPushController())
    }

    func displayServicePage() {
        if !SCUtilities.isInternetAvailable() {
            display?.showNoInternetAvailableDialog(retryHandler: nil,
                                                   showCancelButton: true,
                                                   additionalButtonTitle: nil,
                                                   additionButtonHandler: nil)
            return
        }

        self.display?.showBtnActivityIndicator(true)

        serviceDetail.getButtonActionController(month: wasateCalendarMonth) { [weak self] (viewController, error, isPush) in
            DispatchQueue.main.async {
                self?.wasateCalendarMonth = nil // clearing deeplinkData
                self?.display?.showBtnActivityIndicator(false)

                guard error == nil else {
                    // TODO: display alert to present error
                    return
                }

                guard let controller = viewController else {
                    return
                }

                if isPush {
                    self?.display?.push(viewController: controller)
                } else {
                    self?.display?.present(viewController: controller)
                }
            }
        }
    }

    func displayWasteCalendarViewController(items: [SCModelWasteCalendarItem], address: SCModelWasteCalendarAddress, wasteReminders: [SCHttpModelWasteReminder]) {
        let wasteCalendarViewController = injector.getWasteCalendarViewController(wasteCalendarItems: items, calendarAddress: address, wasteReminders: wasteReminders, item: serviceData, month: nil)
        display?.push(viewController: wasteCalendarViewController)
    }

    func viewDidLoad() {
        if self.displayServicePageDirectly {
            self.displayServicePage()
        }
//        serviceDetail.trackOpenDetailPage()
    }

    func viewWillAppear() { }

    func viewDidAppear() {
        handleDeeplink()
    }
    
    private func handleDeeplink() {
        if isDisplayOverviewScreen {
            isDisplayOverviewScreen = false
            displayServicePage()
        }
    }
    
    func displayServiceStatusPage() {
        if !SCUtilities.isInternetAvailable() {
            display?.showNoInternetAvailableDialog(retryHandler: nil,
                                                   showCancelButton: true,
                                                   additionalButtonTitle: nil,
                                                   additionButtonHandler: nil)
            return
        }

        self.display?.showStatusBtnActivityIndicator(show: true)
        serviceDetail.getServiceStatusButtonActionController { [weak self] viewController, error, isPush in
            DispatchQueue.main.async {
                self?.wasateCalendarMonth = nil // clearing deeplinkData
                self?.display?.showStatusBtnActivityIndicator(show: false)

                guard error == nil else {
                    // TODO: display alert to present error
                    return
                }

                guard let controller = viewController else {
                    return
                }

                if isPush {
                    self?.display?.push(viewController: controller)
                } else {
                    self?.display?.present(viewController: controller)
                }
            }
        }
    }
    
    func getSecondaryButtonText() -> String? {
        serviceDetail.getSecondaryButtonText()
    }
    
    func isShowServiceStatusButton() -> Bool {
        if let service = serviceData.itemFunction,
           service == "Fahrradparken" {
            return true
        }
        return false
    }
}
