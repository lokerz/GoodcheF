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
    let Id : Int
    let Name : String
    let Source : String?
    let Desc : String?
    let Time : Int
    let Image : String?
    var Ingredient : [Ingredient]
    var Step : [[String]]
}

struct Ingredient : Decodable{
    var Name : String
    let Amount : Int
    let Unit : String?
    let Category : String
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
    
    func filterRecipes(){
        print(#function)
        allergenVal = "001000"
        if Array(allergenVal!)[0] == "1"{
            filterGluten()
        }
        if Array(allergenVal!)[1] == "1"{
            filterLactose()
        }
        if Array(allergenVal!)[2] == "1"{
            filterEgg()
        }
        if Array(allergenVal!)[3] == "1"{
            filterCrustacean()
        }
        if Array(allergenVal!)[4] == "1"{
            filterNut()
        }
        if Array(allergenVal!)[5] == "1"{
            filterMSG()
        }
    }
    
    func filterGluten(){
        //ganti bahan jadi alternatif
        let keyword = ["terigu"]
        let keyword2 = ["roti", "spageti", "mie", "bakmi"]

        
    }
    
    func filterLactose(){
        //ganti bahan jadi susu almond/kedelai/kelapa(santan)
        let keyword = ["kacang", "mede", "almond", "kenari", "nut"]

    }
    
    func filterEgg(){
        //resep hilang
        print(#function)
        let keyword = ["telur", "telor"]
        for word in keyword{
            recipeJson?.removeAll(where: {
                $0.Name.lowercased().contains(word) || $0.Ingredient.contains(where: { $0.Name.lowercased().contains(word)
                })
            })
        }
    }
    
    func filterCrustacean(){
        //kalau judul ilang, kalau bahan substitusi kakap
        print(#function)
        let keyword = ["kepiting", "udang", "lobster", "kerang", "rajungan", "siput", "tutut", "udang galah",]
        //remove
        for word in keyword{
            recipeJson?.removeAll(where: {
                $0.Name.lowercased().contains(word)
            })
        }
        //substitute
        for word in keyword{
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Ingredient.count - 1{
                    if recipeJson![i].Ingredient[j].Name.lowercased().contains(word){
                        recipeJson![i].Ingredient[j].Name = recipeJson![i].Ingredient[j].Name.lowercased().replacingOccurrences(of: word, with: "Ikan Kakap")
                    }
                }
            }
        }

    }
    
    func filterNut(){
        //resep hilang
        print(#function)
        let keyword = ["kacang", "mede", "almond", "kenari", "nut"]
    
    }
    
    func filterMSG(){
        print(#function)
        //bahan ganti kaldu organik
        //kaleng -> fresh
        //penyedap -> kaldu organik
        let keyword = ["kaleng"]
        let keyword2 = ["penyedap"]
    }
}
