//
//  RecipeAllViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeHomeViewController: UIViewController {

    @IBOutlet weak var containerViewOutlet: UIView!
    
    lazy var categoryViewController : RecipeCategoryTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeCategoryTableViewController") as! RecipeCategoryTableViewController
        self.addChildController(viewController)
        return viewController
    }()
    lazy var listViewController : RecipeListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeListViewController") as! RecipeListViewController
        self.addChildController(viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewController.view.isHidden = false
        listViewController.view.isHidden = false
//        UIView.animate(withDuration: 0) {
//            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: -1000)
//        }
        setupNavBar()
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
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
    
    func updateSearchResults(for searchController: UISearchController) {
       
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        UIView.animate(withDuration: 1) {
//            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
//        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        UIView.animate(withDuration: 1) {
//            self.listViewController.view.transform = CGAffineTransform(translationX: 0, y: -1000)
//        }
    }
}
