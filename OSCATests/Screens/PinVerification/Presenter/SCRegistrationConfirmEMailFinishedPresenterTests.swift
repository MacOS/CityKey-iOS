//
//  SCRegistrationConfirmEMailFinishedPresenterTests.swift
//  OSCATests
//
//  Created by Bhaskar N S on 16/07/24.
//  Copyright © 2024 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import XCTest
@testable import OSCA

final class SCRegistrationConfirmEMailFinishedPresenterTests: XCTestCase {

    weak private var display : SCRegistrationConfirmEMailFinishedDisplaying?
    
    func prepareSut(injector: SCToolsShowing & SCAdjustTrackingInjection = MockSCInjector(),
                    shouldHideTopImage: Bool = false,
                    presentationType: SCRegistrationConfirmEMailType = .confirmMailForRegistration,
                    completion: (() -> Void)? = nil) -> SCRegistrationConfirmEMailFinishedPresenting {
        let displayer: SCRegistrationConfirmEMailFinishedDisplaying = SCRegistrationConfirmEMailFinishedDisplayer()
        let presenter = SCRegistrationConfirmEMailFinishedPresenter(injector: injector,
                                                           shouldHideTopImage: shouldHideTopImage,
                                                           presentationType: presentationType,
                                                           completionOnSuccess: completion)
        presenter.setDisplay(displayer)
        return presenter
    }
    
    func testViewDidLoadWithConfirmMailPwd() {
        let mockNavTitle = "f_001_forgot_password_btn_reset_password".localized()
        let titleText = "f_003_forgot_password_confirm_success_headline".localized()
        let detailText =  "f_003_forgot_password_confirm_success_details".localized()
        let btnText =  "f_003_forgot_password_confirm_success_login_btn".localized()
        let topImageSymbol = UIImage(named: "icon_reset_password")!

        let sut = prepareSut(presentationType: .confirmMailForPWDReset)
        let displayer = SCRegistrationConfirmEMailFinishedDisplayer()
        self.display = displayer
        sut.setDisplay(displayer)
        sut.viewDidLoad()
        XCTAssertEqual(displayer.navTitle, mockNavTitle)
        XCTAssertEqual(displayer.titleText, titleText)
        XCTAssertEqual(displayer.detailText, detailText)
        XCTAssertEqual(displayer.btnText, btnText)
        XCTAssertEqual(displayer.topImageSymbol.pngData(), topImageSymbol.pngData())
    }
    
    func testViewDidLoadWithConfirmMailSentBeforeRegistration() {
        let mockNavTitle = "r_005_registration_success_title".localized()
        let titleText = "r_005_registration_success_headline".localized()
        let detailText =  "r_005_registration_success_details".localized()
        let btnText =  "r_005_registration_success_login_btn".localized()
        let topImageSymbol = UIImage(named: "icon_confirm_email")!

        let sut = prepareSut(presentationType: .confirmMailForRegistration)
        let displayer = SCRegistrationConfirmEMailFinishedDisplayer()
        self.display = displayer
        sut.setDisplay(displayer)
        sut.viewDidLoad()
        XCTAssertEqual(displayer.navTitle, mockNavTitle)
        XCTAssertEqual(displayer.titleText, titleText)
        XCTAssertEqual(displayer.detailText, detailText)
        XCTAssertEqual(displayer.btnText, btnText)
        XCTAssertEqual(displayer.topImageSymbol.pngData(), topImageSymbol.pngData())
    }
    
    func testViewDidLoadWithConfirmMailForEditEmail() {
        let mockNavTitle = "p_004_profile_email_success_title".localized()
        let titleText = "p_004_profile_email_changed_info_sent_mail".localized()
        let detailText =  "p_004_profile_email_changed_info_received".localized()
        let btnText =  "r_005_registration_success_login_btn".localized()
        let topImageSymbol = UIImage(named: "icon_confirm_email")!

        let sut = prepareSut(presentationType: .confirmMailForEditEmail)
        let displayer = SCRegistrationConfirmEMailFinishedDisplayer()
        self.display = displayer
        sut.setDisplay(displayer)
        sut.viewDidLoad()
        XCTAssertEqual(displayer.navTitle, mockNavTitle)
        XCTAssertEqual(displayer.titleText, titleText)
        XCTAssertEqual(displayer.detailText, detailText)
        XCTAssertEqual(displayer.btnText, btnText)
        XCTAssertEqual(displayer.topImageSymbol.pngData(), topImageSymbol.pngData())
    }
    
    func testFinishedWasPressed() {
        let completionHandler = {
            print("completed##")
        }
        let mockInjector = MockSCInjector()
        let sut = prepareSut(injector: mockInjector,
                             presentationType: .confirmMailForEditEmail,
                             completion: completionHandler)
        sut.finishedWasPressed()
        XCTAssertTrue(mockInjector.isTrackEventCalled)
    }
}


final class SCRegistrationConfirmEMailFinishedDisplayer: SCRegistrationConfirmEMailFinishedDisplaying {
    
    private(set) var titleText: String = ""
    private(set) var detailText: String = ""
    private(set) var btnText: String = ""
    private(set) var topImageSymbol: UIImage = UIImage()
    private(set) var navTitle: String = ""
    
    func setupNavigationBar(title: String) {
        navTitle = title
    }
    
    func setupUI(titleText: String, detailText: String, btnText: String, topImageSymbol: UIImage) {
        self.titleText = titleText
        self.detailText = detailText
        self.btnText = btnText
        self.topImageSymbol = topImageSymbol
    }
    
    func dismissView(completion: (() -> Void)?) {
        
    }
    
    func popViewController() {
        
    }
    
    func hideTopImage() {
        
    }
}
