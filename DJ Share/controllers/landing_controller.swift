//
//  landing.swift
//  DJ Share
//
//  Created by Reilly Freret on 9/14/18.
//  Copyright © 2018 Reilly Freret. All rights reserved.
//

import Foundation
import UIKit

class MainNavController: UITabBarController {
    
    let partyVC = MainPartyController()
    let searchVC = MainSearchController()
    let streamVC = MainStreamController()
    let libVC = MainLibraryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    func setupItems() {
        partyVC.tabBarItem = UITabBarItem(title: "Party", image: #imageLiteral(resourceName: "partyIcon"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "searchIcon"), tag: 1)
        streamVC.tabBarItem = UITabBarItem(title: "Stream", image: #imageLiteral(resourceName: "streamIcon"), tag: 2)
        libVC.tabBarItem = UITabBarItem(title: "Library", image: #imageLiteral(resourceName: "libIcon"), tag: 3)
        self.tabBar.tintColor = UIColor.Theme.redMain
        viewControllers = [partyVC, searchVC, streamVC, libVC]
    }
}
