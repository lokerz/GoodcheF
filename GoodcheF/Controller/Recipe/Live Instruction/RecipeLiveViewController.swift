//
//  RecipeLiveViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit


class RecipeLiveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var liveCollectionView: UICollectionView!
    
    var judul = "Ayam Kremes"
    var steps = [["1","2","3"],["4","5","6"],["7","8"],["9","10"],["11"],["12","13"]]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LiveCollectionViewCell
        
        cell.judulResep.text = judul
        var stepMasak = ""
        for i in steps[indexPath.item]{
            stepMasak.append("\(i)\n\n")
        }
        cell.caraMasakResep.text = stepMasak
        cell.caraMasakResep.backgroundColor = .clear
        
        cell.stepResepKe.text = "Step ke \(pageControl.currentPage + 1) dari \(steps.count)"
        
        cell.judulResep.textColor = .chocoColor
        cell.stepResepKe.textColor = .lightchocoColor
        cell.caraMasakResep.textColor = .darkchocoColor
    
        
        return cell
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = steps.count
        pc.currentPageIndicatorTintColor = .darkchocoColor
        pc.isEnabled = false
        pc.pageIndicatorTintColor = .creamColor
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()

        liveCollectionView.backgroundColor = .yellowColor
        liveCollectionView.layer.cornerRadius = 20.0
        liveCollectionView.isPagingEnabled = true
        
    }

}
