//
//  ServantTableViewCell.swift
//  FateIndex+
//
//  Created by 管君 on 9/26/18.
//  Copyright © 2018 管君. All rights reserved.
//

import UIKit

class ServantTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let avatarTopMargin: CGFloat = 5.0
        static let avatarLeadMargin: CGFloat = 20.0
    }
    
    static let identifier = "ServantTableViewCell"

    var avatar: UIImage? {
        didSet {
            imageView?.image = avatar
        }
    }
    
    var title: String? {
        didSet {
            textLabel?.text = title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView?.layer.cornerRadius = 8.0
        imageView?.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let avatarHeight = bounds.height - 2 * Constants.avatarTopMargin
        let avatarWidth = avatarHeight
        
        imageView?.frame = CGRect(x: Constants.avatarLeadMargin, y: Constants.avatarTopMargin, width: avatarWidth, height: avatarHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatar = nil
        title = nil
    }
}
