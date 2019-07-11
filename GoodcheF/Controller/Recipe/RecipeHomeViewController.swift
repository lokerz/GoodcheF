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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewController.view.isHidden = false
        setupNavBar()
        print((DataManager.shared.recipeDB.first?.step as! NSArray)[0])
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: RecipeListViewController())
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func addChildController(_ childController: UIViewController) {
        addChild(childController)
        containerViewOutlet.addSubview(childController.view)
        childController.view.frame = containerViewOutlet.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParent: self)
    }
}
