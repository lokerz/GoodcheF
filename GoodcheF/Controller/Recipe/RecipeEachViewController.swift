//
//  RecipeEachViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import Speech
import AVKit

class RecipeEachViewController: UIViewController {

    @IBOutlet weak var recipeImageOutlet: UIImageView!
    @IBOutlet weak var recipeTitleOutlet: UILabel!
    @IBOutlet weak var recipeSubtitleOutlet: UILabel!
    @IBOutlet weak var favButtonOutlet: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cookButtonOutlet: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var stepTableView: UITableView!
    
    @IBOutlet weak var ingredientView: UIView!
    @IBOutlet weak var stepView: UIView!
    
    var recipe : Recipe?
    var isFavorite = false
    var categoryArr = [String]()
    var ingredientArr = [[Ingredient]]()
    var img : UIImage?
    var imageArr = ["gluten", "lactose", "egg", "crustacean", "nut", "msg"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        stepTableView.delegate = self
        stepTableView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        ingredientCategorize()
        setupNavBar()
        askIfFavorite()
        setTitle()
        setButtonShadow(cookButtonOutlet)
        setShadow(ingredientView)
        setShadow(stepView)
        setHeight()
        setImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupNavBar(){
        self.title = ""
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)
    }
    
    func setTitle(){
        recipeTitleOutlet.text = recipe?.Name
        
        if let recipe = recipe{
            recipeSubtitleOutlet.text = "Porsi \(recipe.Portion ?? "1") Orang, \(recipe.Time) Menit"
            img = UIImage(named: (recipe.Image)!)
            let imageData = img?.highQuality
            recipeImageOutlet.image = UIImage(data: imageData! as Data)
        }
        
    }
    
    func setShadow(_ view : UIView){
        view.layer.cornerRadius = 15
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        //view.backgroundColor = .clear
    }
    
    func setButtonShadow(_ view : UIButton){
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        //view.backgroundColor = .clear
    }
    
    
    func askIfFavorite(){
        isFavorite = false
        if DataManager.shared.recipeFavorites.contains(recipe!.Id){
            isFavorite = true
            favButtonOutlet.setImage(UIImage(named: "fav"), for: .normal)
        }
        else {
            favButtonOutlet.setImage(UIImage(named: "unfav"), for: .normal)
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
    }
    
    @IBAction func favButtonAction(_ sender: UIButton) {
        var favoriteExist = false
        if isFavorite{
            isFavorite = false
            favButtonOutlet.setImage(UIImage(named: "unfav"), for: .normal)
            for i in 0...DataManager.shared.recipeFavorites.count - 1{
                if recipe?.Id == DataManager.shared.recipeFavorites[i] {
                    DataManager.shared.recipeFavorites.remove(at: i)
                    break
                }
            }
        }else{
            isFavorite = true
            favButtonOutlet.setImage(UIImage(named: "fav"), for: .normal)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "instructionSegue"{
            let vc = segue.destination as! RecipeLiveViewController
            vc.judul = recipe!.Name
            vc.steps = recipe!.Step
        }
    }
    
    @IBAction func cookButtonAction(_ sender: UIButton) {
    }
    
}
extension RecipeEachViewController : UITableViewDelegate, UITableViewDataSource {
    func setHeight(){
        print(ingredientTableView.intrinsicContentSize)
        ingredientTableView.rowHeight = UITableView.automaticDimension
        ingredientTableView.invalidateIntrinsicContentSize()
        ingredientTableView.reloadData()
        
        
        print(stepTableView.intrinsicContentSize)
        stepTableView.rowHeight = UITableView.automaticDimension
        stepTableView.invalidateIntrinsicContentSize()
        stepTableView.reloadData()
        
        ingredientTableView.layoutIfNeeded()
        stepTableView.layoutIfNeeded()
        ingredientView.layoutIfNeeded()
        stepView.layoutIfNeeded()
        
        ingredientView.backgroundColor = .white
        stepView.backgroundColor = .white
        ingredientTableView.backgroundColor = .clear
        stepTableView.backgroundColor = .clear
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
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.textColor = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)
        header.backgroundView?.backgroundColor = .white
        if tableView == ingredientTableView{
            if section == 0 {
                header.textLabel?.text = "Bahan Memasak"
            }
            else{
                header.textLabel?.text = categoryArr[section]
            }
        }
        else{
            header.textLabel?.text = "Cara Memasak"
        }
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
                cell.indentationWidth = 10
            }
            else {
                cell.textLabel?.text = "\(indexPath.row + 1). "
                for step in recipe.Step[indexPath.row]{
                    if let str = step as String?{
                        cell.textLabel?.text = cell.textLabel!.text! + "\(str) "
                    }
                }
                cell.textLabel?.textAlignment = .justified
            }
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.backgroundColor = .clear
        return cell
    }
    

}

extension RecipeEachViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func setImage(){
        imageArr = ["gluten", "lactose", "egg", "crustacean", "nut", "msg"]
        guard let allergenVal = DataManager.shared.allergenVal else {return}
        for i in 0...Array(allergenVal).count - 1{
            if Array(allergenVal)[i] == "1"{
                imageArr[i] = imageArr[i]+"x"
            }
        }
        removeImage()
    }
    
    func removeImage(){
        for i in stride(from : imageArr.count - 1, to: -1, by: -1){
            if !recipe!.Allergen![i]{
                imageArr.remove(at: i)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "intolerantCell", for: indexPath)
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        cell.addSubview(image)
        image.image = UIImage(named: imageArr[indexPath.row])
       
        
        return cell
    }
}

