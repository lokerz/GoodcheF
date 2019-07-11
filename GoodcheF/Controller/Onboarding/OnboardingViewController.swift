//
//  OnboardingViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 09/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
