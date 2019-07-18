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
    var title : String?
    var subtitle : String?
    var imageName : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardOutlet.layer.cornerRadius = 20
        cardOutlet.clipsToBounds = true
        imageName = "AyamSteak"
        title = "Steak Ayam Bumbu Barbeque"
        subtitle = "Porsi 1 Orang, 30 Menit"
        if let image = imageName {
            imageOutlet.image = UIImage(named: image)
        }
        shadowOutlet.backgroundColor = .white
        shadowOutlet.alpha = 0.75
        titleOutlet.text = title
        subtitleOutlet.text = subtitle
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
