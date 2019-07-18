//
//  DataManager.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Recipe : Decodable{
    let Id : Int?
    let Name : String?
    let Source : String?
    let Desc : String?
    let Time : String?
    let Image : String?
    let Ingredient : [Ingredient]?
    let Step : [[String]]
}

struct Ingredient : Decodable{
    let Name : String?
    let Amount : Int?
    let Unit : String?
    let Category : String?
}

class DataManager : NSObject{
    static let shared = DataManager()
    
    let database = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipeJson : [Recipe]?
    var recipeFavorites = [Int]()
    
    private override init(){
        super.init()
        allergenOnboarding = false
        allergenVal = "000000"
    }
    
    let allergenList : [String] = [
        "Gluten",
        "Telur",
        "Produk Susu",
        "Udang, Kepiting dan Kerang",
        "Kacang - kacangan",
        "Pengawet dan Perisa"]
    let allergenSubtitleList : [String] = [
        "Bahan Gluten akan digantikan dengan bahan lain.",
        "Resep dengan Telur akan dihilangkan.",
        "Bahan Produk Susu akan digantikan dengan bahan lain.",
        "Bahan Udang, Kepiting dan Kerang akan digantikan dengan bahan lain.",
        "Resep dengan Kacang - kacangan akan dihilangkan.",
        "Bahan Pengawet dan Perisa akan diganti"
    ]
    var allergenOnboarding : Bool?
    var allergenVal : String?
    
    func saveAllergen(){
        database.set(true, forKey: "allergenOnboarding")
        database.set(allergenVal, forKey: "allergenVal")
    }
    func loadAllergen(){
        allergenOnboarding = database.bool(forKey: "allergenOnboarding")
        allergenVal = database.string(forKey: "allergenVal")
    }
    
    func saveFavorites(){
        database.set(recipeFavorites, forKey: "recipeFavorites")
    }
    
    func loadFavorites(){
        if let database = database.array(forKey: "recipeFavorites") as? [Int] {
            recipeFavorites = database
        }
        print(recipeFavorites)
    }
    
    func loadJson(){
        let path = Bundle.main.path(forResource: "Recipe", ofType: "json")!
        guard let data = NSData(contentsOfFile: path) else {return}
        
        do{
            self.recipeJson = try JSONDecoder().decode([Recipe].self, from: data as Data)
        }catch{
            print(error)
        }
        
    }
}
