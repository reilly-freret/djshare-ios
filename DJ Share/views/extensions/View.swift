//
//  View.swift
//  DJ Share
//
//  Created by Reilly Freret on 9/14/18.
//  Copyright © 2018 Reilly Freret. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(views: UIView...) {
        for v in views {
            self.addSubview(v)
        }
    }
    
}
