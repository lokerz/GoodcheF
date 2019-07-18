//
//  RecipeAllViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

protocol HomeDelegate : AnyObject{
    func recipeOpen(_ recipe : Recipe)
}

class RecipeHomeViewController: UIViewController, HomeDelegate {

    @IBOutlet weak var containerViewOutlet: UIView!
    let searchController = UISearchController(searchResultsController: nil)
    var recipeToOpen : Recipe?
    
    lazy var categoryViewController : RecipeCategoryTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeCategoryTableViewController") as! RecipeCategoryTableViewController
        self.addChildController(viewController)
        return viewController
    }()
    lazy var listViewController : RecipeListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeListViewController") as! RecipeListViewController
        viewController.delegate = self
        self.addChildController(viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewController.view.isHidden = false
        listViewController.view.isHidden = false
        UIView.animate(withDuration: 0) {
            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: -1000)
        }
        setupNavBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeSegue" {
            let vc = segue.destination as! RecipeEachViewController
            vc.recipe = recipeToOpen
        }
    }
    
    func recipeOpen(_ recipe : Recipe){
        print("called")
        recipeToOpen = recipe
        performSegue(withIdentifier: "ShowRecipeSegue", sender: self)
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "What do you want to eat?"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    func addChildController(_ childController: UIViewController) {
        addChild(childController)
        containerViewOutlet.addSubview(childController.view)
        childController.view.frame = containerViewOutlet.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParent: self)
    }
    
    
}


extension RecipeHomeViewController :  UISearchBarDelegate, UISearchResultsUpdating{
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        listViewController.filteredRecipes = listViewController.recipes.filter({( recipe : Recipe) -> Bool in
            return recipe.Name!.lowercased().contains(searchText.lowercased())
        })
        listViewController.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool{
        return !searchBarIsEmpty() && searchController.isActive
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 1) {
            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 1) {
            self.listViewController.tableView.setContentOffset(.zero, animated: false)
            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: -1000)
        }
    }
}


