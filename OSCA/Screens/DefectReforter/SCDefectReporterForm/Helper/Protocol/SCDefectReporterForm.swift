/*
Created by Bhaskar N S on 21/07/22.
Copyright © 2022 Deutsche Telekom AG - VTI Organization. All rights reserved.

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

SPDX-FileCopyrightText: 2025 Deutsche Telekom AG, Bhaskar N S
SPDX-License-Identifier: Apache-2.0 AND LicenseRef-Deutsche-Telekom-Brand
License-Filename: LICENSES/Apache-2.0.txt LICENSES/LicenseRef-Deutsche-Telekom-Brand.txt
*/

import UIKit
import CoreLocation

protocol SCDefectReporterFormViewDisplay : AnyObject, SCDisplaying {
    
    func setDisallowedCharacterForEMail(_ disallowedChars: String)
    func dismissView(animated flag: Bool, completion: (() -> Void)?)
    func dismissKeyboard()
    func setSendReportButtonState(_ state : SCCustomButtonState)
    
    func getValue(for inputField: SCDefectReporterInputFields) -> String?
    func getFieldType(for inputField: SCDefectReporterInputFields) -> SCTextfieldComponentType
    func hideError(for inputField: SCDefectReporterInputFields)
    func showError(for inputField: SCDefectReporterInputFields, text: String)
    func showMessagse(for inputField: SCDefectReporterInputFields, text: String, color: UIColor)
    func scrollContent(to inputField: SCDefectReporterInputFields)
    func deleteContent(for inputField: SCDefectReporterInputFields)
    func updateValidationState(for inputField: SCDefectReporterInputFields, state: SCTextfieldValidationState)
    func getValidationState(for inputField: SCDefectReporterInputFields) -> SCTextfieldValidationState
    func setEnable(for inputField: SCDefectReporterInputFields,enabled : Bool )
    func updateTermsValidationState(_ accepted : Bool, showErrorInfoWhenNotAccepted: Bool)
    func updateTermsCheckbox(accepted: Bool)
    func setTextFieldContainerViewHeight()
    func getDefectImage() -> UIImage?
    func getDefectImageData() -> Data?

    func dismiss(completion: (() -> Void)?)
    func setNavigation(title : String)
    func setupFormUI(_ subCategory: SCModelDefectSubCategory?)
    func reloadDefectLocationMap()
    func push(viewController: UIViewController)
    func present(viewController: UIViewController)
    func moveAccessibilityFocus()
    
}
protocol SCDefectReporterFormPresenting: SCPresenting {
    func setDisplay(_ display: SCDefectReporterFormViewDisplay)
    
    func configureField(_ field: SCTextFieldConfigurable?, identifier: String?, type: SCDefectReporterInputFields, autocapitalizationType: UITextAutocapitalizationType) -> SCTextFieldConfigurable?
    
    func textFieldComponentDidChange(for inputField: SCDefectReporterInputFields)
    func txtFieldEditingDidEnd(value : String, inputField: SCDefectReporterInputFields, textFieldType: SCTextfieldComponentType)
    func termsWasPressed()
    func presentTermsAndConditions()
    func presentRulesOfUse()
    func changeLocationBtnWasPressed()
    func sendReportBtnWasPressed(defectLocation: LocationDetails?)
    func getDefectLocation() -> CLLocation
    func getServiceData() -> SCBaseComponentItem
    func setManadatoryFields() -> [SCDefectReporterInputFields]
    func updateManadatoryFields(_ field: SCDefectReporterInputFields)
    func getProfileData() -> SCModelProfile?
    func updateSendReportBtnState()
    func getServiceFlow() -> Services
}
