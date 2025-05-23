/*
Created by Michael on 20.06.20.
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

SPDX-FileCopyrightText: 2025 Deutsche Telekom AG, Michael
SPDX-License-Identifier: Apache-2.0 AND LicenseRef-Deutsche-Telekom-Brand
License-Filename: LICENSES/Apache-2.0.txt LICENSES/LicenseRef-Deutsche-Telekom-Brand.txt
*/

import UIKit

class SCCityImprintViewController: UIViewController {

    public var presenter:  SCCityImprintPresenting!
    
    var headerheight : CGFloat {
        if UIDevice.current.orientation.isLandscape {
            return CGFloat(Int(self.view.bounds.height * 0.6))
        } else {
            return CGFloat(Int(self.view.bounds.height * 0.3))
        }
    }

    @IBOutlet weak var barBtnLocation: UIBarButtonItem!
    @IBOutlet weak var barBtnProfile: UIBarButtonItem!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerDetailLabel: SCTopAlignLabel!
    @IBOutlet weak var cityImprintBtn: SCCustomButton!
    @IBOutlet weak var contentDetail: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var appPreviewBannerView: UIView!
    @IBOutlet weak var appPreviewBannerLabel: UILabel!

    private var headerTransition : SCHeaderTransition!
    
    private let kTopHeaderHeight : CGFloat = 45.0
    private let kHeaderHeight : CGFloat = 65.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDynamicTypeChange()
        self.shouldNavBarTransparent = true
        self.contentScrollView.addSubview(self.headerView)
        
        self.contentScrollView.showsVerticalScrollIndicator = false
        self.headerTransition = SCHeaderTransition.init(with: self)
        
        self.headerTransition.layoutHeaderView()

        SCUtilities.delay(withTime: 0.0, callback: {self.headerTransition.tintNavigationBar()})

        self.setupAccessibilityIDs()
        self.setupAccessibility()
        
        self.presenter.setDisplay(self)
        self.presenter.viewDidLoad()
        
    }
    
    private func handleDynamicTypeChange() {
        // Dynamic font
        
        // Setup Dynamic font for Imprint
        cityImprintBtn.titleLabel?.adjustsFontForContentSizeCategory = true
        cityImprintBtn.titleLabel?.font = UIFont.SystemFont.regular.forTextStyle(style: .body, size: 16, maxSize: 30)
        contentDetail.adjustsFontForContentSizeCategory = true
        contentDetail.font = UIFont.SystemFont.regular.forTextStyle(style: .body, size: 16, maxSize: nil)
        headerTitleLabel.adjustsFontForContentSizeCategory = true
        headerTitleLabel.font = UIFont.SystemFont.bold.forTextStyle(style: .title1, size: 35, maxSize: 50)
        headerDetailLabel.adjustsFontForContentSizeCategory = true
        headerDetailLabel.font = UIFont.SystemFont.regular.forTextStyle(style: .title2, size: 25, maxSize: 40)
        
    }
    // setup accessibility ids for automated testing
    private func setupAccessibilityIDs(){
        self.barBtnLocation.accessibilityIdentifier = "btn_bar_location"
        self.navigationController?.navigationBar.accessibilityIdentifier = "nvbr"
        self.navigationItem.titleView?.accessibilityIdentifier = "nvitem_title"
    }

    private func setupAccessibility(){
        self.barBtnLocation.accessibilityTraits = .button
        self.barBtnLocation.accessibilityLabel = LocalizationKeys.Common.accessibilityBtnSelectLocation.localized()
        self.barBtnLocation.accessibilityLanguage = SCUtilities.preferredContentLanguage()
        self.barBtnProfile.accessibilityTraits = .button
        self.barBtnProfile.accessibilityLabel = LocalizationKeys.Common.accessibilityBtnOpenProfile.localized()
        self.barBtnProfile.accessibilityLanguage = SCUtilities.preferredContentLanguage()
        navigationItem.titleView?.accessibilityElementsHidden = true
        headerTitleLabel.accessibilityTraits = .header
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshNavigationBarStyle()
        
        self.headerTransition.tintNavigationBar()
        
        self.presenter.viewWillAppear()
        
        UIAccessibility.delayAndSetFocusTo(barBtnLocation)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleAppPreviewBannerView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.headerTransition.layoutHeaderView()
    }
    
     override var preferredStatusBarStyle: UIStatusBarStyle {
         if self.shouldNavBarTransparent {
             return .lightContent
         }
         
         if #available(iOS 13.0, *) {
             switch traitCollection.userInterfaceStyle {
                 case .light, .unspecified:
                     return .darkContent
                 case .dark:
                     return .lightContent
             @unknown default:
                return .darkContent
            }
         } else {
             return .default
         }
         
     }

    /**
     *
     * Action for the Search Location Button
     *
     */
    
    @IBAction func barBtnGeoLocationWasPressed(_ sender: Any) {
        self.presenter.locationButtonWasPressed()
    }
    
    /**
     *
     * Action for the Profile Notifications button
     *
     */
    @IBAction func barBtnProfilenWasPressed(_ sender: Any) {
        self.presenter.profileButtonWasPressed()
    }

    @IBAction func openCityImprintBtnWasPressed(_ sender: Any) {
        self.presenter.imprintButtonWasPressed()
    }
    
}

extension SCCityImprintViewController:  SCCityImprintDisplaying {

    func setupUI() {
        self.navigationItem.title = LocalizationKeys.CitykeyImprint.h001NavigationBarBtnImprint.localized()
        self.headerTitleLabel.adaptFontSize()
        self.headerTitleLabel.text = LocalizationKeys.CitykeyImprint.h001NavigationBarBtnImprint.localized()
        self.cityImprintBtn.customizeCityColorStyle()
        self.cityImprintBtn.setTitle(LocalizationKeys.CitykeyImprint.ci001ButtonText.localized(),
                                     for: .normal)
        self.cityImprintBtn.titleLabel?.adaptFontSize()
    }

    func updateCityName(_ cityName : String) {
        headerDetailLabel.adaptFontSize()
        headerDetailLabel.text = cityName
        self.cityImprintBtn.customizeCityColorStyle()
    }

    func updateCityImage(withURL: SCImageURL?) {
        cityImageView.load(from: withURL)
    }
    
    func updateImprintDesc(_ imprintDesc: String?) {
        self.contentDetail.adaptFontSize()
        self.contentDetail.attributedText = imprintDesc?.applyHyphenation()
    }
    
    func handleAppPreviewBannerView() {
        view.bringSubviewToFront(appPreviewBannerView)
        appPreviewBannerLabel.text = LocalizationKeys.AppPreviewUI.h001HomeAppPreviewBannerText.localized()
        appPreviewBannerView.isHidden = isPreviewMode ? false : true
    }
    
    func updateImprintImage(withUrl: SCImageURL?) {
        
        guard let imprintUrl = withUrl,
        !imprintUrl.absoluteUrlString().isEmpty else {
            self.headerImageView.image = UIImage(named: "cityImprintHeader")
            return
        }
        headerImageView.load(from: imprintUrl)
    }
}
