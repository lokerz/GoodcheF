//
//  RecipeCategoryTableViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 10/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeCategoryTableViewController: UITableViewController {

    let categoryArr = ["Aneka Ayam", "Aneka Nasi", "Aneka Kue dan Dessert", "Favorit"]
    var recipeCategoryArr = [[Recipe]]()
    var recipeSectionIndexArr = [0,1,2,3,4,5,6,7,8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recipeCategoryArr = [[Recipe]]()
        loadCategory("ayam")
        loadCategory("nasi")
        loadCategory("kue")
        loadFavorites()
        
        tableView.reloadData()
        if let cells = tableView.visibleCells as? [RecipeCategoryTableViewCell]{
            for cell in cells{
                cell.reloadTableData()
            }
        }
    }
    
    func loadCategory(_ category : String){
        var tempArr = [Recipe]()
        for recipe in DataManager.shared.recipeJson!{
            if (recipe.Name?.lowercased().contains(category))!{
                tempArr.append(recipe)
            }
        }
        recipeCategoryArr.append(tempArr)
    }
    
    func loadFavorites(){
        var tempArr = [Recipe]()
        //if DataManager.shared.recipeFavorites.count > 0{
            for recipe in DataManager.shared.recipeJson!{
                for favorite in DataManager.shared.recipeFavorites{
                    if recipe.Id == favorite{
                        tempArr.append(recipe)
                    }
                }
            }
       //}
        recipeCategoryArr.append(tempArr)
    }
    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categoryArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryArr[section]
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        header.textLabel?.textColor = .black
        header.backgroundView?.backgroundColor = .white
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for : indexPath) as! RecipeCategoryTableViewCell
        cell.recipes = recipeCategoryArr[indexPath.row + indexPath.section]
        if let parent = self.parent as? RecipeHomeViewController{
            cell.delegate = parent
        }
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
