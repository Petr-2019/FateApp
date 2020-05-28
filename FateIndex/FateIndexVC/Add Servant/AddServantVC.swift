//
//  AddServantVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/27.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class AddServantVC: UIViewController {

    let doneButton = UIButton(frame: .zero)
    let avatarView = UIImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(avatarView)
        view.addSubview(doneButton)

        doneButton.setTitle("完成", for: UIControl.State())
        doneButton.setTitleColor(view.tintColor, for: .normal)
        //doneButton.setTitleColor(, for: .highlighted)

        avatarView.image = UIImage(named: "Servant_1")
        avatarView.layer.cornerRadius = 8.0
        avatarView.clipsToBounds = true

        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        }
        else if traitCollection.userInterfaceStyle == .light {
            view.backgroundColor = .white
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        avatarView.frame = CGRect(x: (view.bounds.width - 70.0) / 2, y: 10.0, width: 70.0, height: 70.0)


        let doneButtonSize = doneButton.sizeThatFits(CGSize(width: (view.bounds.width - 70.0 - 20) / 2, height: CGFloat.greatestFiniteMagnitude))
        doneButton.frame = CGRect(x: view.bounds.width - 20.0 - doneButtonSize.width, y: 10.0, width: doneButtonSize.width, height: doneButtonSize.height)
    }

}
