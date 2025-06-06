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
//  SCPWDRestoreUnlockVCTests.swift
//  OSCATests
//
//  Created by Bhaskar N S on 10/07/24.
//  Copyright © 2024 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import XCTest
@testable import OSCA

final class SCPWDRestoreUnlockVCTests: XCTestCase {
    
    private func prepareSut() -> SCPWDRestoreUnlockVC {
        let storyboard = UIStoryboard(name: "PwdRestoreUnlockScreen", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "RestoreUnlockVC") as! SCPWDRestoreUnlockVC
        sut.presenter = SCPWDRestoreUnlockPresenterMock()
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testViewDidLoad() {
        let sut = prepareSut()
        sut.viewDidLoad()
        guard let presenter = sut.presenter as? SCPWDRestoreUnlockPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isViewDidLoadCalled)
    }
    
    func testRecoveryBtnWasPressed() {
        let sut = prepareSut()
        sut.recoveryBtnWasPressed(UIButton())
        guard let presenter = sut.presenter as? SCPWDRestoreUnlockPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isRecoveryBtnCalled)
    }
    
    func testCancelBtnWasPressed() {
        let sut = prepareSut()
        sut.cancelBtnWasPressed(UIButton())
        guard let presenter = sut.presenter as? SCPWDRestoreUnlockPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isCancelWasCalled)
    }
    
    func testRestoreField() {
        let sut = prepareSut()
        let restore = sut.restoreField(for: sut.txtfldEmail)
        XCTAssertNotNil(restore)
        XCTAssertEqual(.email, restore!)
    }
    
    func testSetupNavigationBar() {
        let title = "l_001_login_title".localized()
        let backTitle = ""
        let sut = prepareSut()
        sut.setupNavigationBar(title: title, backTitle: backTitle)
        XCTAssertEqual(sut.navigationItem.title, title)
    }
    
    func testRefreshUI() {
        let screenTitle = "f_001_forgot_password_btn_reset_password".localized()
        let detail = "f_001_forgot_password_info_click_link".localized()
        let iconName = "icon_reset_password"
        let btnText = "f_001_forgot_password_btn_reset_password".localized()
        let defaultEmail = "test@gmail.com"
        let sut = prepareSut()
        sut.refreshUI(screenTitle: screenTitle, detail: detail, iconName: iconName, btnText: btnText, defaultEmail: defaultEmail)
        XCTAssertEqual(detail, sut.detailLabel?.text)
        XCTAssertEqual(screenTitle, sut.navigationItem.title)
        XCTAssertEqual(UIImage(named: iconName)?.pngData(), sut.iconImageView.image?.pngData())
        XCTAssertEqual(btnText, sut.recoverBtn.titleLabel?.text)
    }
    
    func testViewDidAppear() {
        let sut = prepareSut()
        sut.viewDidAppear(true)
        XCTAssertTrue(sut.pwdCheckVCHeightConstraint.constant != 0)
    }
    
    func testSetRecoverButtonState() {
        let sut = prepareSut()
        sut.setRecoverButtonState(.progress)
        XCTAssertEqual(sut.recoverBtn.btnState, .progress)
        XCTAssertEqual(sut.recoverButtonState(), .progress)
    }
    
    func testOverlay() {
        let sut = prepareSut()
        var navTitle = "navTitle"
        sut.overlay(viewController: UIViewController(), title: navTitle)
        XCTAssertEqual(sut.navigationItem.title, navTitle)
        XCTAssertNil(sut.navigationItem.backBarButtonItem)
    }
    
    func testDeleteContent() {
        let sut = prepareSut()
        sut.deleteContent(for: .email)
        XCTAssertEqual(sut.txtfldEmail?.text, "")
    }
    
    func testGetValue() {
        let sut = prepareSut()
        sut.txtfldEmail?.text = "test@gmail.com"
        let email = sut.getValue(for: .email)
        XCTAssertEqual(sut.txtfldEmail?.text, email)
    }
    
    func testGetFieldType() {
        let sut = prepareSut()
        sut.viewDidLoad()
        sut.txtfldPwd1?.text = "test@gmail.com"

        let pwdType = sut.getFieldType(for: .pwd1)
        XCTAssertEqual(pwdType, SCTextfieldComponentType.password)
    }
        
    func testGetValidationState() {
        let sut = prepareSut()
        sut.txtfldEmail?.text = "test@gmail"
        let state = sut.getValidationState(for: .email)
        XCTAssertEqual(SCTextfieldValidationState.unmarked, state)
    }
    
    func testHideError() {
        let sut = prepareSut()
        sut.hideError(for: .email)
        XCTAssertTrue(sut.txtfldEmail?.errorLabel.isHidden ?? false)
        XCTAssertEqual(SCTextfieldValidationState.unmarked, sut.txtfldEmail?.validationState)
    }
    
    func testSetEnable() {
        let sut = prepareSut()
        sut.setEnable(for: .email, enabled: true)
        XCTAssertTrue(sut.txtfldEmail?.isEnabled() ?? false)
    }
    
    func testShowError() {
        let sut = prepareSut()
        sut.showError(for: .email, text: "error")
        XCTAssertFalse(sut.txtfldEmail?.errorLabel.isHidden ?? true)
        XCTAssertEqual(sut.txtfldEmail?.errorLabel.text, "error")
    }
    
    func testSetupUI() {
        let sut = prepareSut()
        sut.setupUI()
        XCTAssertEqual(sut.txtfldEmail?.disallowedCharacters, " ")
    }
    
    func testTextFiledShouldReturn() {
        let sut = prepareSut()
        let isReturn = sut.textFieldComponentShouldReturn(component: sut.txtfldEmail!)
        XCTAssertTrue(isReturn)
    }
    
    func testTextFieldComponentEditingEnd() {
        let sut = prepareSut()
        sut.textFieldComponentEditingEnd(component: sut.txtfldPwd1!)
        guard let presenter = sut.presenter as? SCPWDRestoreUnlockPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isDidEndCalled)
    }
    
    func testTextFieldComponentDidChange() {
        let sut = prepareSut()
        sut.textFieldComponentDidChange(component: sut.txtfldEmail!)
        guard let presenter = sut.presenter as? SCPWDRestoreUnlockPresenterMock else {
            XCTFail("Test Failed")
            return
        }
        XCTAssertTrue(presenter.isComponentDidChangeCalled)
    }
}

class SCPWDRestoreUnlockPresenterMock: SCPWDRestoreUnlockPresenting {
    private(set) var isViewDidLoadCalled: Bool = false
    private(set) var isRecoveryBtnCalled: Bool = false
    private(set) var isCancelWasCalled: Bool = false
    private(set) var isDidEndCalled: Bool = false
    private(set) var isComponentDidChangeCalled: Bool = false
    
    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
    func setDisplay(_ display: OSCA.SCPWDRestoreUnlockDisplaying) {
        
    }
    
    func configureField(_ field: OSCA.SCTextFieldConfigurable?, identifier: String?, type: OSCA.SCPWDRestoreUnlockInputFields, autocapitalizationType: UITextAutocapitalizationType) -> OSCA.SCTextFieldConfigurable? {
        guard let textfield = field else {
            return nil
        }
        switch type {
        case .email:
            textfield.configure(placeholder: "Email", fieldType: .email, maxCharCount: 255, autocapitalization: .none)
            return field
        case .pwd1:
            textfield.configure(placeholder: "password", fieldType: .password, maxCharCount: 255, autocapitalization: .none)
            return textfield
        case .pwd2:
            textfield.configure(placeholder: "confirm password", fieldType: .password, maxCharCount: 255, autocapitalization: .none)
            return textfield
        }
    }
    
    func textFieldComponentDidChange(for inputField: OSCA.SCPWDRestoreUnlockInputFields) {
        isComponentDidChangeCalled = true
    }
    
    func txtFieldEditingDidEnd(value: String, inputField: OSCA.SCPWDRestoreUnlockInputFields, textFieldType: OSCA.SCTextfieldComponentType) {
        isDidEndCalled = true
    }
    
    func recoveryWasPressed() {
        isRecoveryBtnCalled = true
    }
    
    func cancelWasPressed() {
        isCancelWasCalled = true
    }
}
