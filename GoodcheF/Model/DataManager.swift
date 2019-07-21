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
    let Portion : String?
    var Ingredient : [Ingredient]
    var Step : [[String]]
    var Allergen: [Bool]?
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
        allergenVal = "100100"
        checkAllergen()
        if Array(allergenVal!)[0] == "1"{
            //filter done
            filterGluten()
        }
        if Array(allergenVal!)[1] == "1"{
            //filter done
            filterLactose()
        }
        if Array(allergenVal!)[2] == "1"{
            //filter done
            filterEgg()
        }
        if Array(allergenVal!)[3] == "1"{
            //filter done
            filterCrustacean()
        }
        if Array(allergenVal!)[4] == "1"{
            //filter done
            filterNut()
        }
        if Array(allergenVal!)[5] == "1"{
            //filter done
            filterMSG()
        }
    }
    
    func checkAllergen(){
        print((#function))
        let keyword = [
            ["terigu", "roti", "spageti", "mie", "bakmi"]
            ,["susu", "susu sapi"]
            ,["telur", "telor"]
            ,["kepiting", "udang", "lobster", "kerang", "rajungan", "siput", "tutut", "udang galah",]
            ,["kacang", "mede", "almond", "kenari", "nut"]
            ,["kaleng", "penyedap"]
        ]
        for j in 0...recipeJson!.count - 1{
            recipeJson![j].Allergen = [Bool]()
            
            for i in 0...keyword.count - 1 {
                var temp = false
                for key in keyword[i]{
                    if recipeJson![j].Name.lowercased().contains(key) || recipeJson![j].Ingredient.contains(where: {$0.Name.lowercased().contains(key)}) {
                        temp = true
                        break
                    }
                }
                recipeJson![j].Allergen?.append(temp)
            }
        }
    }
    
    func filterGluten(){
        //ganti bahan jadi alternatif
        let keyword = ["terigu"]
        let keyword2 = ["roti", "spageti", "mie", "bakmi"]

        
        //substitute terigu
        for word in keyword{
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Ingredient.count - 1{
                    if recipeJson![i].Ingredient[j].Name.lowercased().contains(word){
                        let flour = Double(recipeJson![i].Ingredient[j].Amount)
                        let rice = 0.5 * flour
                        let tapioca = 0.25 * flour
                        let corn = 0.25 * flour
                        let unit = recipeJson![i].Ingredient[j].Unit!
                        recipeJson![i].Ingredient[j].Name = recipeJson![i].Ingredient[j].Name.lowercased().replacingOccurrences(of: word, with: "pengganti Tepung Terigu:\n - \(rice) \(unit) tepung beras\n - \(tapioca) \(unit) tepung tapioka\n - \(corn) \(unit) tepung jagung")
                    }
                }
            }
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Step.count - 1{
                    for k in 0...recipeJson![i].Step[j].count - 1{
                        if recipeJson![i].Step[j][k].lowercased().contains(word){
                            recipeJson![i].Step[j][k] = recipeJson![i].Step[j][k].lowercased().replacingOccurrences(of: word, with: "pengganti Tepung Terigu")
                        }
                    }
                }
            }
        }
        
        for word in keyword2{
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Ingredient.count - 1{
                    if recipeJson![i].Ingredient[j].Name.lowercased().contains(word){
                        recipeJson![i].Ingredient[j].Name = recipeJson![i].Ingredient[j].Name + " non Gluten"
                    }
                }
            }
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Step.count - 1{
                    for k in 0...recipeJson![i].Step[j].count - 1{
                        if recipeJson![i].Step[j][k].lowercased().contains(word){
                            recipeJson![i].Step[j][k] = recipeJson![i].Step[j][k].lowercased().replacingOccurrences(of: word, with: word + " non Gluten")
                        }
                    }
                }
            }
        }
    }
    
    func filterLactose(){
        //ganti bahan jadi susu almond/kedelai/kelapa(santan)
        let keyword = ["susu", "susu sapi"]

        for word in keyword{
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Ingredient.count - 1{
                    if recipeJson![i].Ingredient[j].Name.lowercased().contains(word){
                        recipeJson![i].Ingredient[j].Name = "susu almond/kedelai/kelapa"
                    }
                }
            }
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Step.count - 1{
                    for k in 0...recipeJson![i].Step[j].count - 1{
                        if recipeJson![i].Step[j][k].lowercased().contains(word){
                            recipeJson![i].Step[j][k] = recipeJson![i].Step[j][k].lowercased().replacingOccurrences(of: word, with: "susu almond/kedelai/kelapa")
                        }
                    }
                }
            }
        }
    }
    
    func filterEgg(){
        //resep hilang
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
        let keyword = ["kepiting", "udang", "lobster", "kerang", "rajungan", "siput", "tutut", "udang galah"]
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
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Step.count - 1{
                    for k in 0...recipeJson![i].Step[j].count - 1{
                        if recipeJson![i].Step[j][k].lowercased().contains(word){
                            recipeJson![i].Step[j][k] = recipeJson![i].Step[j][k].lowercased().replacingOccurrences(of: word, with: "ikan kakap")
                        }
                    }
                }
            }
        }
    }
    
    func filterNut(){
        //resep hilang
        let keyword = ["kacang", "mede", "almond", "kenari", "nut"]
    
        for word in keyword{
            recipeJson?.removeAll(where: {
                $0.Ingredient.contains(where: {
                    $0.Name.contains(word)
                })
            })
        }
    }
    
    func filterMSG(){
        //bahan ganti kaldu organik
        //kaleng -> fresh
        //penyedap -> kaldu organik
        let keyword = ["kaleng"]
        let keyword2 = ["penyedap"]
        
        for word in keyword{
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Ingredient.count - 1{
                    if recipeJson![i].Ingredient[j].Name.lowercased().contains(word){
                        recipeJson![i].Ingredient[j].Name = recipeJson![i].Ingredient[j].Name.lowercased().replacingOccurrences(of: word, with: " segar")
                    }
                }
            }
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Step.count - 1{
                    for k in 0...recipeJson![i].Step[j].count - 1{
                        if recipeJson![i].Step[j][k].lowercased().contains(word){
                            recipeJson![i].Step[j][k] = recipeJson![i].Step[j][k].lowercased().replacingOccurrences(of: word, with: " segar")
                        }
                    }
                }
            }
        }
        
        for word in keyword2{
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Ingredient.count - 1{
                    if recipeJson![i].Ingredient[j].Name.lowercased().contains(word){
                        recipeJson![i].Ingredient[j].Name = recipeJson![i].Ingredient[j].Name.lowercased().replacingOccurrences(of: word, with: "kaldu organik")
                    }
                }
            }
            for i in 0...recipeJson!.count - 1{
                for j in 0...recipeJson![i].Step.count - 1{
                    for k in 0...recipeJson![i].Step[j].count - 1{
                        if recipeJson![i].Step[j][k].lowercased().contains(word){
                            recipeJson![i].Step[j][k] = recipeJson![i].Step[j][k].lowercased().replacingOccurrences(of: word, with: "kaldu organik")
                        }
                    }
                }
            }
        }
    }
}
