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
    
    var imageArr = ["gluten", "lactose", "egg", "crustacean", "nut", "msg"]
    var recipe : Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       //print("collection cell called")
        
    }
    
    override func prepareForReuse() {
        
    }
    func setCell(){
        guard let recipe = recipe else {return}
        titleOutlet.text = recipe.Name
        subtitleOutlet.text = "Porsi \(recipe.Portion ?? "1") Orang, \(recipe.Time) Menit"
        let img = UIImage(named: recipe.Image!)!
        let imageData = img.lowQuality
        imageOutlet.image = UIImage(data: imageData as Data)
        
        contentViewOutlet.layer.cornerRadius = 15
        contentViewOutlet.layer.masksToBounds = true
        
        self.backgroundColor = .clear
        setShadow()
        
        shadowOutlet.backgroundColor = .white
        shadowOutlet.alpha = 0.70
    }
    
    func setShadow(){
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4

    }
    
    func setImage(){
        guard let allergenVal = DataManager.shared.allergenVal else {return}
        for i in 0...Array(allergenVal).count - 1{
            if Array(allergenVal)[i] == "1"{
                imageArr[i] = imageArr[i]+"x"
            }
        }
        removeImage()
    }
    
    func removeImage(){
        for i in stride(from : imageArr.count - 1, to: 0, by: -1){
            if !recipe!.Allergen![i]{
                imageArr.remove(at: i)
            }
        }
    }
}
