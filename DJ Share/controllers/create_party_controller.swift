//
//  create_party_view.swift
//  DJ Share
//
//  Created by Reilly Freret on 9/16/18.
//  Copyright © 2018 Reilly Freret. All rights reserved.
//

import Foundation
import UIKit

class CreatePartyForm: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupView()
    }
    
    func setupView() {
        self.title = "Create a Party"
    }
}
