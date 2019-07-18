//
//  RecipeCategoryTableViewCell.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 11/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit


class RecipeCategoryTableViewCell: UITableViewCell {
    weak var delegate : HomeDelegate?
    var recipes = [Recipe]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RecipeCardCollectionCell", bundle: nil), forCellWithReuseIdentifier: "recipeCardCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadTableData(){
        collectionView.reloadData()
    }

}

extension RecipeCategoryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCardCollectionCell", for : indexPath) as! RecipeCardCollectionCell
        cell.backgroundColor = .green
        cell.titleOutlet.text = recipes[indexPath.row].Name
        cell.subtitleOutlet.text = recipes[indexPath.row].Time
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe : Recipe
        recipe = recipes[indexPath.row]
        self.delegate?.recipeOpen(recipe)
    }
    
}
