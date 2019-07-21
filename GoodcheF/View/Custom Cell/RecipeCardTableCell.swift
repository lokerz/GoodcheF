//
//  RecipeCardTableCell.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 15/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeCardTableCell: UITableViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var shadowOutlet: UIView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var subtitleOutlet: UILabel!
    
    @IBOutlet weak var cardOutlet: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(){
        cardOutlet.layer.shadowColor = UIColor.lightGray.cgColor
        cardOutlet.layer.shadowOpacity = 0.3
        cardOutlet.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardOutlet.layer.shadowRadius = 7
        cardOutlet.backgroundColor = .clear
        
        imageOutlet.layer.cornerRadius = 15
        imageOutlet.layer.masksToBounds = true
        
        shadowOutlet.layer.cornerRadius = 15
        let path = UIBezierPath(roundedRect: shadowOutlet.bounds,
                                byRoundingCorners:[.topLeft, .topRight],
                               cornerRadii: CGSize(width: 0, height:  0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        shadowOutlet.layer.mask = maskLayer
        shadowOutlet.backgroundColor = .white
        shadowOutlet.alpha = 1
    }
    
}
