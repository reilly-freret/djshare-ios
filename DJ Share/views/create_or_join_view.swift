//
//  landing_view.swift
//  DJ Share
//
//  Created by Reilly Freret on 9/14/18.
//  Copyright © 2018 Reilly Freret. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class CreateOrJoinView: UIViewController {

    let createAddPartyButton: UIButton = {
        let button = UIButton()
        button.autoSetDimensions(to: CGSize(width: 150, height: 150))
        //button.setImage(#imageLiteral(resourceName: "testIcon"), for: .normal)
        button.setTitle("Create", for: .normal)
        button.tag = 0
        button.backgroundColor = UIColor.Theme.redMain
        button.addTarget(self, action: #selector(goToCreate(_:)), for: .touchUpInside)
        return button
    }()
    
    let createJoinPartyButton: UIButton = {
        let button = UIButton()
        button.autoSetDimensions(to: CGSize(width: 150, height: 150))
        //button.setImage(#imageLiteral(resourceName: "joinIcon"), for: .normal)
        button.setTitle("Join", for: .normal)
        button.tag = 1
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(goToJoin(_:)), for: .touchUpInside)
        return button
    }()
    
    func setupView() {
        let bc = UIStackView()
        bc.autoSetDimensions(to: CGSize(width: 150, height: 320))
        bc.axis = .vertical
        bc.alignment = .center
        bc.distribution = .equalSpacing
        bc.spacing = 20
        bc.addArrangedSubview(self.createAddPartyButton)
        bc.addArrangedSubview(self.createJoinPartyButton)
        bc.backgroundColor = UIColor.green
        self.view.addSubview(bc)
        self.view.subviews[0].autoCenterInSuperview()
        self.title = "Party"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc func goToJoin(_ sender: UIButton) {
        print("\njoin")
    }
    
    @objc func goToCreate(_ sender: UIButton) {
        print("\ncreate")
        let c = CreatePartyForm()
        self.navigationController?.pushViewController(c, animated: true)
    }
}
