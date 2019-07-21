//
//  SwipingController+extension.swift
//  GoodcheF
//
//  Created by Aditya Sanjaya on 19/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

extension RecipeLiveViewController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { (_) in
//            self.collectionViewLayout.invalidateLayout()

            if self.pageControl.currentPage == 0 {
                self.liveCollectionView.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.liveCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }

        }) { (_) in
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height)
//    }
    

}
