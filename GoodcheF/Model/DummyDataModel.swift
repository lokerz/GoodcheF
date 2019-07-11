//
//  DummyDataModel.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 10/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DummyDataModel : NSObject{
    static let shared = DummyDataModel()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    func loadDummyDatabase(){
        let recipe = Recipe(context: context)
        recipe.name = "Ayam Kremes"
        recipe.source = "Primarasa"
        recipe.desc = "Bumbunya sederhana, membuatnya pun mudah, namun rasanya sungguh lezat. Resep Ayam Kremes menggunakan taburan tepung berbumbu yang digoreng kering dan renyah. Karena renyahnya sehingga mudah diremas (dikremes)."
        recipe.time = "90 menit"
        recipe.picture = "AyamKremes"
        recipe.ingredient = [
            "1 ekor (750 g) ayam kampung",
            "300 ml minyak untuk menggoreng",
            "25 g tepung terigu",
            "25 g tepung beras",
            "150 ml air",
        
            "Bumbu halus",
            "1 sdt ketumbar sangrai",
            "1-2 sdt garam",
            "15 butir kemiri",
            "6 siung bawang putih"
            ] as [NSString] as NSArray
        recipe.step = [
            "1. Potong-potong ayam menjadi 4 bagian atau biarkan utuh. Lumuri dengan bumbu halus, remas-remas hingga bumbu merata. Biarkan selama 1 jam atau lebih agar bumbu meresap.",
            "2. Taruh ayam berbumbu dalam panci/wajan, tuangi air, masak hingga mendidih, kecilkan api dan tutup panci/wajan, masak terus selama ± 1 jam hingga airnya mengering. Matikan api, keluarkan ayam dari panci, pisahkan bumbunya, sisihkan.",
            "3. Campur sisa bumbu dengan tepung terigu, tepung beras, tuangi 150 ml air, aduk rata.",
            "4. Panaskan minyak goreng yang banyak dalam wajan, masukkan ayam hingga terendam minyak. Goreng hingga ¾ matang, masukkan ½ bagian bumbu secara bertahap. Goreng hingga ayam dan bumbu kering, angkat, tiriskan.",
            "5. Lanjutkan menggoreng sisa bumbu secara bertahap hingga bumbu kering dan renyah, angkat, tiriskan.",
            "6. Taruh ayam di atas piring saji, taburi dengan tepung bumbu yang kering dan renyah, hidangkan selagi hangat."
            ] as [NSString] as NSArray
        DataManager.shared.recipeDB.append(recipe)
    }
}
