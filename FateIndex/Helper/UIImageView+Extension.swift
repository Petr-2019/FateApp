//
//  UIImageView+Extension.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/28.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
