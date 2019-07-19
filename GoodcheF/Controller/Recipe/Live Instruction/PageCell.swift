//
//  PageCell.swift
//  GoodcheF
//
//  Created by Aditya Sanjaya on 19/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            
            guard let unwrappedPage = page else { return }
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.titleText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 157/255, green: 77/255, blue: 79/255, alpha: 1)])
            
            attributedText.append(NSAttributedString(string: "\n\(unwrappedPage.headerText)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36), NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 215/255, green: 155/255, blue: 112/255, alpha: 1)]))
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 58/255, green: 6/255, blue: 4/255, alpha: 1)]))
            
            liveTextView.attributedText = attributedText
            liveTextView.textAlignment = .left
            
        }
    }
    
    private let liveTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "MULAI MEMASAK", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n Katakan\n 'Next' untuk melanjutkan\n 'Back' untuk kembali\n\n atau geser dan ketuk dimana saja", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        addSubview(liveTextView)
        liveTextView.layer.cornerRadius = 10.0
        liveTextView.backgroundColor = UIColor(red: 252/255, green: 223/255, blue: 128/255, alpha: 1)
        liveTextView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        liveTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        liveTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        liveTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
