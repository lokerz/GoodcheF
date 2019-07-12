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
    
    var title : String?
    var subtitle : String?
    var image : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        image = "AyamSteak"
        title = "Steak Ayam Bumbu Barbeque"
        subtitle = "Porsi 1 Orang, 30 Menit"
        if let image = image {
            imageOutlet.image = UIImage(named: image)
        }
        shadowOutlet.backgroundColor = .white
        shadowOutlet.alpha = 0.75
        titleOutlet.text = title
        subtitleOutlet.text = subtitle
    }

}
