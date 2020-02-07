//
//  ClassSkillDetailViewController.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/1/26.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ClassSkillDetailViewController: UIViewController {

    private struct Constants {
        static let topMargin: CGFloat = 10.0
        static let imageSize: CGFloat = 72.0
    }

    private let imageView = UIImageView(frame: .zero)
    private let label = UILabel(frame: .zero)

    private let classSkill: Servant.ClassSkill

    init(classSkill: Servant.ClassSkill) {
        self.classSkill = classSkill
        super.init(nibName: nil, bundle: nil)

        imageView.image = UIImageUtility.classSkillImage(named: classSkill.type)
        view.addSubview(imageView)
        view.backgroundColor = .white
        title = classSkill.name

        view.addSubview(label)

        // label.text = classSkill.effect[0].
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let imageX = (view.bounds.width - Constants.imageSize) / 2
        let imageY = view.safeAreaInsets.top + Constants.topMargin
        imageView.frame = CGRect(x: imageX, y: imageY, width: Constants.imageSize, height: Constants.imageSize)
    }
}
