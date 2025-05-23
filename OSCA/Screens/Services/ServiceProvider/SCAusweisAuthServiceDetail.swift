/*
Created by Bharat Jagtap on 22/02/21.
Copyright © 2021 Deutsche Telekom AG - VTI Organization. All rights reserved.

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

SPDX-FileCopyrightText: 2025 Deutsche Telekom AG, Bharat Jagtap
SPDX-License-Identifier: Apache-2.0 AND LicenseRef-Deutsche-Telekom-Brand
License-Filename: LICENSES/Apache-2.0.txt LICENSES/LicenseRef-Deutsche-Telekom-Brand.txt
*/

import Foundation
import UIKit


class SCAusweisAuthServiceDetail: SCServiceDetailProvider {

    private let serviceData: SCBaseComponentItem
    private let injector: SCServicesInjecting & SCAdjustTrackingInjection
    private let userCityContentSharedWorker: SCUserCityContentSharedWorking

    init(serviceData: SCBaseComponentItem,
         injector: SCServicesInjecting & SCAdjustTrackingInjection,
         userCityContentSharedWorker: SCUserCityContentSharedWorking) {
        self.serviceData = serviceData
        self.injector = injector
        self.userCityContentSharedWorker = userCityContentSharedWorker
    }

    func getServiceTitle() -> String {
        return serviceData.itemTitle
    }

    func getBadgeDescriptionText() -> String? {
        return serviceData.helpLinkTitle;
    }
    
    func getServiceID() -> String {
        serviceData.itemID
    }

    func getButtonText() -> String {
        return serviceData.itemBtnActions?.first?.title ?? ""
    }

    func getBadgeCount() -> String {
        return ""
    }

    func getPushController() -> UIViewController {
        //injector.getAppointmentOverviewController(serviceData: serviceData)
        return injector.getServicesMoreInfoViewController(for: self, injector: injector)
    }

    func getButtonActionController() -> UIViewController? {
        if let detailBtnAction = serviceData.itemBtnActions?.first,
            let createMeetingUri = detailBtnAction.modelServiceAction?.iosUri,
            let actionUrl = URL(string: createMeetingUri) {
            return injector.getTEVISViewController(for: actionUrl.absoluteString, serviceData: serviceData)
        }
        return nil
    }

    func getButtonActionController(month: String?, completion: @escaping (UIViewController?, SCWorkerError?, Bool) -> Void) {
        
        /*
        if let detailBtnAction = serviceData.itemBtnActions?.first,
            let createMeetingUri = detailBtnAction.modelServiceAction?.iosUri,
            let actionUrl = URL(string: createMeetingUri) {
            let controller = injector.getTEVISViewController(for: actionUrl.absoluteString)
            completion(controller, nil, false)
        }
        completion(nil, nil, false)
         */
        guard let url = serviceData.itemBtnActions?.first?.modelServiceAction?.iosUri else {
            completion(nil, nil , false)
            return
        }
        let title = serviceData.itemTitle
        let serviceWebDetails = SCModelEgovServiceWebDetails(serviceTitle: title , serviceURL: url, serviceType: "eidform")
        let controller = injector.getAusweisAuthServicesDetailController(for: serviceWebDetails)
        completion(controller, nil, true)
        
    }
}
