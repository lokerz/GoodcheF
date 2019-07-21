//
//  RecipeCategoryTableViewCell.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 11/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit


class RecipeCategoryTableViewCell: UITableViewCell {
    weak var homeDelegate : HomeDelegate?
    var recipes = [Recipe]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RecipeCardCollectionCell", bundle: nil), forCellWithReuseIdentifier: "recipeCardCollectionCell")
    }

    override func prepareForReuse() {
        recipes = [Recipe]()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadTableData(){
        collectionView.reloadData()
        if let cells = collectionView.visibleCells as? [RecipeCardCollectionCell]{
            for cell in cells{
                cell.reloadCellData()
            }
        }
        
    }
}

extension RecipeCategoryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCardCollectionCell", for : indexPath) as! RecipeCardCollectionCell
        cell.recipe = recipes[indexPath.row]
        cell.setCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe : Recipe
        recipe = recipes[indexPath.row]
        self.homeDelegate?.recipeOpen(recipe)
      
    }
}

extension UIImage
{
    var highestQuality: NSData { return jpegData(compressionQuality: 1)! as NSData }
    var highQuality: NSData { return jpegData(compressionQuality: 0.75)! as NSData }
    var midQuality: NSData { return jpegData(compressionQuality: 0.5)! as NSData }
    var lowQuality: NSData { return jpegData(compressionQuality: 0.25)! as NSData }
    var lowestQuality: NSData { return jpegData(compressionQuality: 0)! as NSData }
}
