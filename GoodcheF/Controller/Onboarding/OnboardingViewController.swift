//
//  OnboardingViewController.swift
//  mc2morrow
//
//  Created by Aditya Sanjaya on 21/07/19.
//  Copyright © 2019 Aditya. All rights reserved.
//

import UIKit

extension UIColor {
    static var darkchocoColor = UIColor(red: 58/255, green: 6/255, blue: 4/255, alpha: 1)
    static var chocoColor = UIColor(red: 157/255, green: 77/255, blue: 79/255, alpha: 1)
    static var lightchocoColor = UIColor(red: 215/255, green: 155/255, blue: 112/255, alpha: 1)
    static var yellowColor = UIColor(red: 252/255, green: 223/255, blue: 128/255, alpha: 1)
    static var creamColor = UIColor(red: 251/255, green: 235/255, blue: 231/255, alpha: 1)
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingBGOutlet: UIView!
    @IBOutlet weak var headerOutlet: UILabel!
    @IBOutlet weak var footerOutlet: UILabel!
    
    @IBOutlet weak var glutenTitleOutlet: UILabel!
    @IBOutlet weak var susuTitleOutlet: UILabel!
    @IBOutlet weak var telurTitleOutlet: UILabel!
    @IBOutlet weak var kepitingTitleOutlet: UILabel!
    @IBOutlet weak var kacangTitleOutlet: UILabel!
    @IBOutlet weak var kimiaTitleOutlet: UILabel!
    
    @IBOutlet weak var glutenSubtitleOutlet: UILabel!
    @IBOutlet weak var susuSubtitleOutlet: UILabel!
    @IBOutlet weak var telurSubtitleOutlet: UILabel!
    @IBOutlet weak var kepitingSubtitleOutlet: UILabel!
    @IBOutlet weak var kacangSubtitleOutlet: UILabel!
    @IBOutlet weak var kimiaSubtitleOutlet: UILabel!
    
    @IBOutlet weak var glutenCheckmark: UIButton!
    @IBOutlet weak var susuCheckmark: UIButton!
    @IBOutlet weak var telurCheckmark: UIButton!
    @IBOutlet weak var kepitingCheckmark: UIButton!
    @IBOutlet weak var kacangCheckmark: UIButton!
    @IBOutlet weak var kimiaCheckmark: UIButton!
    
    
    @IBOutlet weak var simpanButton: UIButton!
    @IBOutlet weak var lewatiButton: UIButton!
    
    
    var gluten = false
    var susu = false
    var telur = false
    var kepiting = false
    var kacang = false
    var kimia = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCheckmark()
        setLabel()
        setBackground()
        setButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setCheckmark(){
        let allergenVal = DataManager.shared.allergenVal
        
        if Array(allergenVal!)[0] == "1"{
            gluten = true
            checkedAction(gluten, glutenCheckmark, glutenSubtitleOutlet)
        }
        if Array(allergenVal!)[1] == "1"{
            susu = true
            checkedAction(susu, susuCheckmark, susuSubtitleOutlet)
        }
        if Array(allergenVal!)[2] == "1"{
            telur = true
            checkedAction(telur, telurCheckmark, telurSubtitleOutlet)
        }
        if Array(allergenVal!)[3] == "1"{
            kepiting = true
            checkedAction(kepiting, kepitingCheckmark, kepitingSubtitleOutlet)
        }
        if Array(allergenVal!)[4] == "1"{
            kacang = true
            checkedAction(kacang, kacangCheckmark, kacangSubtitleOutlet)
        }
        if Array(allergenVal!)[5] == "1"{
            kimia = true
            checkedAction(kimia, kimiaCheckmark, kimiaSubtitleOutlet)
        }
    }
    func setLabel(){
        headerOutlet.text = "Saya \nalergi / intoleran \nterhadap:"
        headerOutlet.textColor = .darkchocoColor
        footerOutlet.text = "Pilihan anda akan digunakan untuk memilah resep sesuai dengan kebutuhan anda."
        footerOutlet.textColor = .darkchocoColor
        glutenTitleOutlet.text = DataManager.shared.allergenList[0]
        glutenSubtitleOutlet.text = DataManager.shared.allergenSubtitleList[0]
        susuTitleOutlet.text = DataManager.shared.allergenList[1]
        susuSubtitleOutlet.text = DataManager.shared.allergenSubtitleList[1]
        telurTitleOutlet.text = DataManager.shared.allergenList[2]
        telurSubtitleOutlet.text = DataManager.shared.allergenSubtitleList[2]
        kepitingTitleOutlet.text = DataManager.shared.allergenList[3]
        kepitingSubtitleOutlet.text = DataManager.shared.allergenSubtitleList[3]
        kacangTitleOutlet.text = DataManager.shared.allergenList[4]
        kacangSubtitleOutlet.text = DataManager.shared.allergenSubtitleList[4]
        kimiaTitleOutlet.text = DataManager.shared.allergenList[5]
        kimiaSubtitleOutlet.text = DataManager.shared.allergenSubtitleList[5]
    }
    
    func setBackground(){
        onboardingBGOutlet.backgroundColor = .yellowColor
        onboardingBGOutlet.layer.cornerRadius = 20.0
    }
    
    func setButton(){
        simpanButton.setTitle("Simpan", for: .normal)
        simpanButton.backgroundColor = .yellowColor
        simpanButton.setTitleColor(.darkchocoColor, for: .normal)
        simpanButton.layer.cornerRadius = 20.0
        
        lewatiButton.setTitle("Lewati", for: .normal)
        lewatiButton.setTitleColor(.darkchocoColor, for: .normal)
    }
    
    func checkedAction(_ state : Bool,_ check : UIButton,_ subtitle : UILabel){
        if state{
            check.setImage(UIImage(named: "Checked"), for: .normal)
            subtitle.isHidden = false
        }
        else{
            check.setImage(UIImage(named: "checkBox"), for: .normal)
            subtitle.isHidden = true
        }
    }

    @IBAction func ClickAction(_ sender: UIButton){
        switch sender.tag {
        case 0 :
            gluten =  !gluten
            checkedAction(gluten, glutenCheckmark, glutenSubtitleOutlet)
        case 1 :
            susu = !susu
            checkedAction(susu, susuCheckmark, susuSubtitleOutlet)
        case 2 :
            telur =  !telur
            checkedAction(telur, telurCheckmark, telurSubtitleOutlet)
        case 3 :
            kepiting =  !kepiting
            checkedAction(kepiting, kepitingCheckmark, kepitingSubtitleOutlet)
        case 4 :
            kacang =  !kacang
            checkedAction(kacang, kacangCheckmark, kacangSubtitleOutlet)
        default:
            kimia =  !kimia
            checkedAction(kimia, kimiaCheckmark, kimiaSubtitleOutlet)
        }
    }

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getCheckmark() -> String{
        var checkedMark = ""
        let arr = [gluten, susu, telur, kepiting, kacang, kimia]
        for member in arr{
            if member {
                checkedMark += "1"
            }else{
                checkedMark += "0"
            }
        }
        print (checkedMark)
        return checkedMark
    }
    
    @IBAction func simpanButtonAction(_ sender: Any) {
        DataManager.shared.allergenVal = getCheckmark()
        DataManager.shared.saveAllergen()
        DataManager.shared.loadJson()
        DataManager.shared.loadFavorites()
        DataManager.shared.filterRecipes()
        performSegue(withIdentifier: "ResepSegue", sender: self)
    }
    
    @IBAction func lewatiButtonAction(_ sender: Any) {
        DataManager.shared.saveAllergen()
        performSegue(withIdentifier: "ResepSegue", sender: self)

    }
}
