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


class DataManager : NSObject{
    static let shared = DataManager()
    let database = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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
    var recipeDB = [Recipe]()
    
    func saveAllergen(){
        database.set(true, forKey: "allergenOnboarding")
        database.set(allergenVal, forKey: "allergenVal")
    }
    func loadAllergen(){
        allergenOnboarding = database.bool(forKey: "allergenOnboarding")
        allergenVal = database.string(forKey: "allergenVal")
    }
    
    func saveDatabase(){
        do {
            try context.save()
        } catch {
            print("error save", error)
        }
    }
    func loadDatabase(){
        DummyDataModel.shared.loadDummyDatabase()
    }
}
