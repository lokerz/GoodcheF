//
//  RecipeCardCollectionCell.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 11/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeCardCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var subtitleOutlet: UILabel!
    @IBOutlet weak var shadowOutlet: UIView!
    @IBOutlet weak var contentViewOutlet: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       //print("collection cell called")
        
    }
    
    override func prepareForReuse() {
        
    }
    func setCell(){
        contentViewOutlet.layer.cornerRadius = 15
        contentViewOutlet.layer.masksToBounds = true
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 6
        self.backgroundColor = .clear

        shadowOutlet.backgroundColor = .white
        shadowOutlet.alpha = 0.70
    }
}
