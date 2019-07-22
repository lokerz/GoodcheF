//
//  RecipeCategoryTableViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 10/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit


class RecipeCategoryTableViewController: UITableViewController {
    

    var categoryArr = ["Ayam & Bebek", "Daging Sapi & Kambing", "Hasil Laut", "Aneka Nasi", "Mie & Pasta", "Dibawah 30 Menit", "Favorit"]
    var categories = [
        ["ayam", "bebek"],
        ["sapi", "kambing"],
        ["ikan", "cumi", "udang", "kerang", "kepiting", "lobster"],
        ["nasi"],
        ["mie", "bihun", "spag"],
    ]
    var recipeCategoryArr = [[Recipe]]()
    var countArr = [Int]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCategory()
        removeCategory()
        reloadData()
    }
    
    func reloadData(){
        tableView.reloadData()
        if let cells = tableView.visibleCells as? [RecipeCategoryTableViewCell]{
            for cell in cells{
                cell.reloadTableData()
            }
        }
    }
    
    func loadCategory(){
        categoryArr = ["Ayam & Bebek", "Daging Sapi & Kambing", "Hasil Laut", "Aneka Nasi", "Mie & Pasta", "Dibawah 30 Menit", "Favorit"]
        categories = [
            ["ayam", "bebek"],
            ["sapi", "kambing"],
            ["ikan", "cumi", "udang", "kerang", "kepiting", "lobster"],
            ["nasi"],
            ["mie", "bihun", "spag"],
        ]
        recipeCategoryArr = [[Recipe]]()
        countArr = [Int]()
        for category in categories{
            loadCategory(category)
        }
        loadTime()
        loadFavorites()
       
    }
    
    func loadCategory(_ category : [String]){
        var tempArr = [Recipe]()
        count = 0
        for recipe in DataManager.shared.recipeJson!{
            for item in category{
                if recipe.Name.lowercased().contains(item) && !tempArr.contains(where: {$0.Name == recipe.Name}){
                    print(recipe.Name, category)
                    count += 1
                    tempArr.append(recipe)
                }
                else if recipe.Ingredient.contains(where: { $0.Name.lowercased().contains(item)}) && !tempArr.contains(where: {$0.Name == recipe.Name}){
                    count += 1
                    tempArr.append(recipe)
                }
            }
        }
        countArr.append(count)
        recipeCategoryArr.append(tempArr)
    }
    
    func loadTime(){
        count = 0
        var tempArr = [Recipe]()
        for recipe in DataManager.shared.recipeJson!{
            if recipe.Time <= 30{
                tempArr.append(recipe)
                count += 1
            }
        }
        countArr.append(count)
        recipeCategoryArr.append(tempArr)
    }
    
    func loadFavorites(){
        count = 0
        var tempArr = [Recipe]()
        for recipe in DataManager.shared.recipeJson!{
            for favorite in DataManager.shared.recipeFavorites{
                if recipe.Id == favorite{
                    tempArr.append(recipe)
                    count += 1
                }
            }
        }
        countArr.append(count)
        recipeCategoryArr.append(tempArr)
    }
    
    func removeCategory(){
        print(countArr)
        for i in stride(from: countArr.count - 1, to: 0, by: -1){
            if countArr[i] == 0 {
                categoryArr.remove(at: i)
                recipeCategoryArr.remove(at: i)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categoryArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryArr[section]
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        header.textLabel?.textColor = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)
        header.textLabel?.text = categoryArr[section].capitalized
        header.backgroundView?.backgroundColor = .clear
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        footer.backgroundView?.backgroundColor = .clear
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 29
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for : indexPath) as! RecipeCategoryTableViewCell
        cell.recipes = recipeCategoryArr[indexPath.section]
        if let parent = self.parent as? RecipeHomeViewController{
            cell.homeDelegate = parent
        }
        cell.selectionStyle = .none 
        cell.backgroundView?.backgroundColor = .white
        cell.reloadTableData()
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
