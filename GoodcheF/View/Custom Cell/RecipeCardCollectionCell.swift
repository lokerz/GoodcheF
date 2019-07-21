//
//  RecipeCardCollectionCell.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 11/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class RecipeCardCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var subtitleOutlet: UILabel!
    @IBOutlet weak var shadowOutlet: UIView!
    @IBOutlet weak var contentViewOutlet: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArr = ["gluten", "lactose", "egg", "crustacean", "nut", "msg"]
    var recipe : Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCollectionViewCell")
       //print("collection cell called")
        
    }
    
    override func prepareForReuse() {
        
    }
    func reloadCellData(){
        collectionView.reloadData()
    }
    
    func setCell(){
        guard let recipe = recipe else {return}
        titleOutlet.text = recipe.Name
        subtitleOutlet.text = "Porsi \(recipe.Portion ?? "1") Orang, \(recipe.Time) Menit"
        let img = UIImage(named: recipe.Image!)!
        let imageData = img.lowQuality
        imageOutlet.image = UIImage(data: imageData as Data)
        
        contentViewOutlet.layer.cornerRadius = 15
        contentViewOutlet.layer.masksToBounds = true
        
        self.backgroundColor = .clear
        setShadow()
        removeImage()
        collectionView.alpha = 1
        shadowOutlet.backgroundColor = .white
        shadowOutlet.alpha = 0.70
    }
    
    func setShadow(){
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4

    }
    
}

extension RecipeCardCollectionCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 30, height: 30)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath)
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        cell.addSubview(image)
        image.image = UIImage(named: imageArr[indexPath.row])
        return cell
    }
    
    func removeImage(){
        for i in stride(from : imageArr.count - 1, to: 0, by: -1){
            if !recipe!.Allergen![i]{
                imageArr.remove(at: i)
            }
        }
    }
    
}
