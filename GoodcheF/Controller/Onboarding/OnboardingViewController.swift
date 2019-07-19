//
//  OnboardingViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 09/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var onBoardingView: UIView!
    @IBOutlet weak var headerText: UITextView!
    @IBOutlet weak var footerText: UITextView!
    @IBOutlet weak var simpanButtonOutlet: UIButton!
    @IBOutlet weak var lewatiButtonOutlet: UIButton!
    
    let allergenTitles: [String] = ["Gluten (terigu/gandum)", "Produk susu", "Telur", "Udang/kerang/kepiting", "Kacang", "Pengawet & Perisa"]
    let allergenSubtitles: [String] = ["Bahan gluten akan diubah secara otomatis dengan bahan lain.", "Bahan susu akan diubah secara otomatis dengan bahan lain", "Bahan telur akan otomatis dihilangkan dari resep", "Bahan udang/kerang/kepiting akan dihilangkan dari resep", "Bahan kacang akan dihilangkan dari resep", "Pengawet & perisa akan diubah secara otomatis dengan bahan lain"]
    let allergenImages: [String] = ["GLUTEN", "DAIRY", "EGG", "SHELLFISH", "NUTS", "BENZOAT"]
    let cellReuseIdentifier = "cell"
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        tableView.separatorColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
    }
    
    func setupLayout(){
        
        setView()
        setText()
        setButton()
        
    }
    
    func setView(){
        onBoardingView.layer.cornerRadius = 20.0
        onBoardingView.backgroundColor = UIColor(red: 252/255, green: 223/255, blue: 128/255, alpha: 1)
    }
    
    func  setText(){
        let attributedHeaderText = NSMutableAttributedString(string: "Saya \nalergi/intoleran \nterhadap:", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36), NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 58/255, green: 6/255, blue: 4/255, alpha: 1)])
        
        let attributedFooterText = NSMutableAttributedString(string: "Pilihan anda akan digunakan untuk memilah resep sesuai dengan kebutuhan anda.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 58/255, green: 6/255, blue: 4/255, alpha: 1)])
        
        headerText.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        footerText.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        headerText.attributedText = attributedHeaderText
        footerText.attributedText = attributedFooterText
        headerText.isEditable = false
        footerText.isEditable = false
        headerText.isScrollEnabled = false
        footerText.isScrollEnabled = false
    }
    
    func setButton(){
        simpanButtonOutlet.backgroundColor = UIColor(red: 252/255, green: 223/255, blue: 128/255, alpha: 1)
        simpanButtonOutlet.layer.cornerRadius = 20.0
        simpanButtonOutlet.setTitle("Simpan", for: .normal)
        simpanButtonOutlet.setTitleColor(UIColor.init(displayP3Red: 58/255, green: 6/255, blue: 4/255, alpha: 1), for: .normal)
        simpanButtonOutlet.frame = CGRect(x: 80, y: 750, width: 254, height: 40)
        
        lewatiButtonOutlet.setTitle("Lewati", for: .normal)
        lewatiButtonOutlet.setTitleColor(.black, for: .normal)
        lewatiButtonOutlet.frame = CGRect(x: 80, y: 800, width: 254, height: 40)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allergenTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyCustomCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
        
        cell.myCellTitle.text = self.allergenTitles[indexPath.row]
        cell.myCellTitle.font = UIFont(name: "SF Pro Text", size: 19)
        cell.myCellTitle.textColor = UIColor.init(displayP3Red: 58/255, green: 6/255, blue: 4/255, alpha: 1)
        
        
        cell.myCellSubtitle.text = self.allergenSubtitles[indexPath.row]
        cell.myCellSubtitle.font = UIFont(name: "SF Pro Text", size: 12)
        cell.myCellSubtitle.textColor = UIColor.init(displayP3Red: 58/255, green: 6/255, blue: 4/255, alpha: 1)
        
        
        cell.self.backgroundColor = UIColor(red: 2/255, green: 0/255, blue: 0/255, alpha: 0)
        
        return cell
    }
    

    
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func getCheckmark() -> String{
        let checkedMark = "000000"
        
        return checkedMark
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton){
        DataManager.shared.allergenVal = getCheckmark()
        DataManager.shared.saveAllergen()
        
    }
    @IBAction func skipButtonAction(_ sender: UIButton) {
        DataManager.shared.saveAllergen()
        performSegue(withIdentifier: "ResepSegue", sender: self)
    }
    
}
