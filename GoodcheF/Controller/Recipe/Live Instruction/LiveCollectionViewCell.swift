//
//  LiveCollectionViewCell.swift
//  GoodcheF
//
//  Created by Aditya Sanjaya on 21/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class LiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var judulResep: UILabel!
    @IBOutlet weak var stepResepKe: UILabel!
    @IBOutlet weak var caraMasakResep: UITextView!
    @IBOutlet weak var cardBackground: UIView!
    
    weak var liveDelegate : LiveDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(nextPage))
        tap.numberOfTapsRequired = 1
        cardBackground.addGestureRecognizer(tap)
    }
    
    @objc func nextPage(){
        liveDelegate?.swipeNext()
    }
}
