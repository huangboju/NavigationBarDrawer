//
//  CustomCell.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/7/14.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

class CustomCell: UICollectionViewCell {
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: self.bounds)
        textLabel.backgroundColor = .groupTableViewBackground
        return textLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(textLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
