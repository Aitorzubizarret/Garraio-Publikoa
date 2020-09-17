//
//  InfoPanelViewController.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 13/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class InfoPanelViewController: UIViewController {

    // MARK: - UI
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var companyLogoImageview: UIImageView!
    @IBOutlet weak var stopNameLabel: UILabel!
    @IBOutlet weak var stopExtraLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        self.stopExtraLabel.text = ""
        self.companyNameLabel.font = self.companyNameLabel.font.withSize(12)
    }
}
