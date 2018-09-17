//
//  party_controller.swift
//  DJ Share
//
//  Created by Reilly Freret on 9/16/18.
//  Copyright © 2018 Reilly Freret. All rights reserved.
//

import Foundation

class MainPartyController: UINavigationController {
    
    let buttonSet: CreateOrJoinView = {
        let bv = CreateOrJoinView()
        return bv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.pushViewController(buttonSet, animated: false)
    }
}
