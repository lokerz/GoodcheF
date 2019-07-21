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
        listViewController.view.isHidden = true
//        UIView.animate(withDuration: 0) {
//            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: -1000)
//        }
        setupNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeSegue" {
            let vc = segue.destination as! RecipeEachViewController
            vc.recipe = recipeToOpen
        }
    }
    
    func recipeOpen(_ recipe : Recipe){
        recipeToOpen = recipe
        performSegue(withIdentifier: "ShowRecipeSegue", sender: self)
    }
    
    func setupNavBar(){
        let color = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : color]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color]

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Makan apa ya?"
        searchController.searchBar.tintColor = #colorLiteral(red: 0.296022743, green: 0.03586935252, blue: 0.01109559834, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
            return recipe.Name.lowercased().contains(searchText.lowercased())
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
       
        listViewController.tableView.layoutIfNeeded()
        listViewController.tableView.beginUpdates()
        listViewController.tableView.setContentOffset(.zero, animated: false)
        listViewController.tableView.endUpdates()
        
        categoryViewController.view.isHidden = true
        listViewController.view.isHidden = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        listViewController.tableView.layoutIfNeeded()
        listViewController.tableView.beginUpdates()
        listViewController.tableView.setContentOffset(.zero, animated: false)
        listViewController.tableView.endUpdates()
        
        categoryViewController.view.isHidden = false
        listViewController.view.isHidden = true
    }
}


