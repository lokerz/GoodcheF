//
//  RecipeListViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 09/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeListViewController: UITableViewController {

    weak var delegate : HomeDelegate?
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "RecipeCardTableCell", bundle: nil), forCellReuseIdentifier: "recipeCardTableCell")
        recipes = DataManager.shared.recipeJson!
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let parent = self.parent as? RecipeHomeViewController{
            isFiltering = parent.isFiltering()
        }
        
        if isFiltering {
            return filteredRecipes.count
        }
        else{
            return recipes.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe : Recipe
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCardTableCell", for: indexPath) as! RecipeCardTableCell
        
        if let parent = self.parent as? RecipeHomeViewController{
            isFiltering = parent.isFiltering()
        }
        if isFiltering {
            recipe = filteredRecipes[indexPath.row]
        }
        else{
            recipe = recipes[indexPath.row]
        }
        cell.titleOutlet.text = recipe.Name
        cell.subtitleOutlet.text = "Porsi \(recipes[indexPath.row].Portion ?? "1") Orang, \(recipes[indexPath.row].Time) Menit"
        cell.selectionStyle = .none
        
        let img = UIImage(named: recipe.Image!)!
        let imageData = img.highQuality
        cell.imageOutlet.image = UIImage(data: imageData as Data)
        
        cell.setCell()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe : Recipe
        if let parent = self.parent as? RecipeHomeViewController{
            isFiltering = parent.isFiltering()
            if isFiltering {
                recipe = filteredRecipes[indexPath.row]
            }
            else{
                recipe = recipes[indexPath.row]
            }
            self.delegate?.recipeOpen(recipe)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
