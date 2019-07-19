//
//  RecipeLiveViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainColor = UIColor(red: 58/255, green: 6/255, blue: 4/255, alpha: 1)
}

class RecipeLiveViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(titleText: "Ayam Kremes", headerText: "STEP 1 dari 6", bodyText: "Potong-potong ayam menjadi 4 bagian atau biarkan utuh.\n\nLumuri dengan bumbu halus, remas-remas hingga bumbu merata.\n\nBiarkan selama 1 jam atau lebih agar bumbu meresap."),
        Page(titleText: "Ayam Kremes", headerText: "STEP 2 dari 6", bodyText: "Taruh ayam berbumbu dalam panci/wajan, tuangi air, masak hingga mendidih, kecilkan api dan tutup panci/wajan, masak terus selama ± 1 jam hingga airnya mengering.\n\nMatikan api, keluarkan ayam dari panci, pisahkan bumbunya, sisihkan."),
        Page(titleText: "Ayam Kremes", headerText: "STEP 3 dari 6", bodyText: "Campur sisa bumbu dengan tepung terigu, tepung beras, tuangi 150 ml air, aduk rata."),
        Page(titleText: "Ayam Kremes", headerText: "STEP 4 dari 6", bodyText: "Panaskan minyak goreng yang banyak dalam wajan, masukkan ayam hingga terendam minyak.\n\nGoreng hingga ¾ matang, masukkan ½ bagian bumbu secara bertahap. \n\nGoreng hingga ayam dan bumbu kering, angkat, tiriskan."),
        Page(titleText: "Ayam Kremes", headerText: "STEP 5 dari 6", bodyText: "Lanjutkan menggoreng sisa bumbu secara bertahap hingga bumbu kering dan renyah, angkat, tiriskan."),
        Page(titleText: "Ayam Kremes", headerText: "STEP 6 dari 6", bodyText: "Taruh ayam di atas piring saji, taburi dengan tepung bumbu yang kering dan renyah, hidangkan selagi hangat.")
    ]
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count + 1
        pc.currentPageIndicatorTintColor = .mainColor
        pc.isEnabled = false
        pc.pageIndicatorTintColor = UIColor(red: 251/255, green: 235/255, blue: 231/255, alpha: 1)
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }

}
