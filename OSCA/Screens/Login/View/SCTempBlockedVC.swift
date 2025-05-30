/*
Created by Michael on 19.02.20
Copyright © 2019 Deutsche Telekom AG - VTI Organization. All rights reserved.

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

class SCTempBlockedVC: UIViewController {
  
    public var presenter: SCTempBlockedPresenter!

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resetLabel: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAccessibilityIDs()
        self.shouldNavBarTransparent = false
        
        self.presenter.setDisplay(self)
        self.presenter.viewDidLoad()

        self.view.setNeedsLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshNavigationBarStyle()
    }

    // setup accessibility ids for automated testing
    private func setupAccessibilityIDs(){
        self.topImageView.accessibilityIdentifier = "img_top"
        self.titleLabel.accessibilityIdentifier = "lbl_title"
        self.resetBtn.accessibilityIdentifier = "btn_reset"
        self.resetLabel.accessibilityIdentifier = "lbl_reset"
        self.navigationController?.navigationBar.accessibilityIdentifier = "nvbr"
        self.navigationItem.titleView?.accessibilityIdentifier = "nvitem_title"
    }


    @IBAction func resetBtnWasPressed(_ sender: Any) {
        self.presenter.resetWasPressed()
    }
    
    @IBAction func closeButtonWasPressed(_ sender: UIBarButtonItem) {
        self.presenter.finishWasPressed()
    }
}

extension SCTempBlockedVC: SCTempBlockedDisplaying {
    func setupNavigationBar(title: String){
        self.navigationItem.title = title
        // remove the Back button
        self.navigationItem.hidesBackButton = true
    }
    
    func setupUI(){
        self.titleLabel.adaptFontSize()
        self.titleLabel.text = "f_001_temp_blocked_main_label".localized()
        self.resetLabel.adaptFontSize()
        self.resetLabel.text = "f_001_temp_blocked_hint_label".localized()
        self.resetBtn.setTitle("f_001_temp_blocked_reset_btn".localized(), for: .normal)
        self.resetBtn.titleLabel?.adaptFontSize()
        
        self.view.setNeedsLayout()
        // Do any additional setup after loading the view.
        
        
    }
    
    func push(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func dismissView(completion: (() -> Void)? = nil) {
        self.dismiss(animated: false, completion: completion)
    }

}
