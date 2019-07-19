//
//  RecipeEachViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeEachViewController: UIViewController {

    @IBOutlet weak var recipeTitleOutlet: UILabel!
    @IBOutlet weak var recipeSubtitleOutlet: UILabel!
    @IBOutlet weak var favButtonOutlet: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cookButtonOutlet: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var stepTableView: UITableView!
    
    var recipe : Recipe?
    var isFavorite = false
    var categoryArr = [String]()
    var ingredientArr = [[Ingredient]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        stepTableView.delegate = self
        stepTableView.dataSource = self
        recipeTitleOutlet.text = recipe?.Name

        setupNavBar()
        askIfFavorite()
        setHeight()
        ingredientCategorize()
        
    }
    
    func setupNavBar(){
        self.title = ""
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func askIfFavorite(){
        for recipe in DataManager.shared.recipeFavorites{
            if self.recipe?.Id == recipe{
                isFavorite = true
                favButtonOutlet.backgroundColor = .red
                break
            }
        }
    }
    
    func ingredientCategorize(){
        var categoryExist = false
        
        for ingredient in recipe!.Ingredient {
            for category in categoryArr{
                if ingredient.Category == category{
                    categoryExist = true
                }
                else {
                    categoryExist = false
                }
            }
            if !categoryExist {
                categoryArr.append(ingredient.Category)
            }
        }
        for i in 0...categoryArr.count - 1 {
            var tempArr = [Ingredient]()
            for ingredient in recipe!.Ingredient {
                if ingredient.Category == categoryArr[i] {
                    tempArr.append(ingredient)
                }
            }
            ingredientArr.append(tempArr)
        }
        print( ingredientArr)
    }
    
    @IBAction func favButtonAction(_ sender: UIButton) {
        var favoriteExist = false
        if isFavorite{
            isFavorite = false
            favButtonOutlet.backgroundColor = .white
            for i in 0...DataManager.shared.recipeFavorites.count - 1{
                if recipe?.Id == DataManager.shared.recipeFavorites[i] {
                    DataManager.shared.recipeFavorites.remove(at: i)
                    break
                }
            }
        }else{
            isFavorite = true
            favButtonOutlet.backgroundColor = .red
            for favorite in DataManager.shared.recipeFavorites{
                if recipe?.Id == favorite {
                    favoriteExist = true
                }
            }
            if !favoriteExist{
                DataManager.shared.recipeFavorites.append((recipe?.Id)!)
            }
        }
        DataManager.shared.saveFavorites()
    }
    
    
    
}
extension RecipeEachViewController : UITableViewDelegate, UITableViewDataSource {
    func setHeight(){
        for constraint in ingredientTableView.constraints {
            if constraint.identifier == "ingredientTableHeight"{
                constraint.constant = CGFloat(45 * ((recipe?.Ingredient.count)! + ingredientTableView.numberOfSections))
            }
        }
        for constraint in stepTableView.constraints {
            if constraint.identifier == "stepTableHeight"{
                constraint.constant = CGFloat(44 * ((recipe?.Step.count)! + stepTableView.numberOfSections))
            }
        }
        
        ingredientTableView.layoutIfNeeded()
        stepTableView.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == ingredientTableView{
            return categoryArr.count
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == ingredientTableView{
            if section == 0 {
                return "Bahan Memasak"
            }
            else{
                return categoryArr[section]
            }
        }
        else{
            return "Cara Memasak"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        header.textLabel?.textColor = .black
        header.backgroundView?.backgroundColor = .white
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientTableView {
            return ingredientArr[section].count
        }
        else {
            return (recipe?.Step.count)!
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let recipe = recipe{
            if tableView == ingredientTableView {
                if ingredientArr[indexPath.section][indexPath.row].Amount > 0{
                cell.textLabel?.text = "\(ingredientArr[indexPath.section][indexPath.row].Amount) \(ingredientArr[indexPath.section][indexPath.row].Unit ?? "") \(ingredientArr[indexPath.section][indexPath.row].Name)"
                }
                else {
                    cell.textLabel?.text = "\(ingredientArr[indexPath.section][indexPath.row].Unit ?? "") \(ingredientArr[indexPath.section][indexPath.row].Name)"
                }
            }
            else {
                cell.textLabel?.text = "\(indexPath.row + 1). "
                for step in recipe.Step[indexPath.row]{
                    if let str = step as String?{
                        cell.textLabel?.text = cell.textLabel!.text! + "\(str) "
                    }
                }
            }
        }
        return cell
    }

}

extension RecipeEachViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)
        return cell
    }
    
    
}
