/*
Created by Bharat Jagtap on 30/06/21.
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

class SCDataPrivacySettingsPresenter {
    
    weak private var display: SCDataPrivacySettingsDisplay?
    private var appContentSharedWorker: SCAppContentSharedWorking
    private var injector : SCLegalInfoInjecting
    private let shouldPushDataPrivacyController : Bool
    private let preventSwipeToDismiss : Bool
    private let isFirstRunSettings: Bool
    var completionHandler: (() -> Void)?
    
    init(appContentSharedWorker: SCAppContentSharedWorking , injector : SCLegalInfoInjecting , shouldPushDataPrivacyController : Bool, preventSwipeToDismiss : Bool, isFirstRunSettings: Bool) {
        
        self.appContentSharedWorker = appContentSharedWorker
        self.injector = injector
        self.shouldPushDataPrivacyController = shouldPushDataPrivacyController
        self.preventSwipeToDismiss = preventSwipeToDismiss
        self.isFirstRunSettings = isFirstRunSettings
    }
}

extension SCDataPrivacySettingsPresenter : SCDataPrivacySettingsPresenting {
        
    func setDisplay(_ display: SCDataPrivacySettingsDisplay) {
        self.display = display
    }
    
    func backButtonPressed() {
                
    }
    
    func dataPrivacyLinkPressed() {
        
//        let viewController = injector.getDataPrivacyController(presentationType: .dataPrivacy, insideNavCtrl: false)
        
        if shouldPushDataPrivacyController {
            let viewController = injector.getDataPrivacyController(preventSwipeToDismiss: true, shouldPushSettingsController: false)
            display?.push(viewController)
        } else {
            
            display?.popViewController()
        }
    }
    
    func acceptSelectedPressed(adjustSwitchStatus: Bool) {
        self.appContentSharedWorker.privacyOptOutMoEngage = true
        self.appContentSharedWorker.privacyOptOutAdjust = !adjustSwitchStatus
        self.appContentSharedWorker.trackingPermissionFinished = true
        if isFirstRunSettings {
            display?.dismiss(completionHandler: completionHandler)
        } else {
            display?.popViewController()
        }
    }
    
    func acceptAllPressed() {
        self.appContentSharedWorker.privacyOptOutMoEngage = true
        self.appContentSharedWorker.privacyOptOutAdjust = false
        self.appContentSharedWorker.trackingPermissionFinished = true
        if isFirstRunSettings {
            display?.dismiss(completionHandler: completionHandler)
        } else {
            display?.popViewController()
        }
    }
    
    func viewDidLoad() {
        
        if preventSwipeToDismiss {
            
            display?.preventSwipeToDismiss()
        }
        
        display?.setupUI(navigationTitle: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsTitle.localized(),
                         title: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsHeadline.localized(),
                         description: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsDescription.localized(),
                         moengageTitle: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsRequiredHeadline.localized(),
                         moengageDescription: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsRequiredDescription.localized(),
                         adjustTitle: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsOptionalHeadline.localized(),
                         adjustDescription: LocalizationKeys.DataPrivacySettings.dialogDpnSettingsOptionalDescription.localized(),
                         adjustEnabled: !appContentSharedWorker.privacyOptOutAdjust)
    }
}
