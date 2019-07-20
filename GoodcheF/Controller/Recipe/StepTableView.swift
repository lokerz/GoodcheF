//
//  StepTableView.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 20/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class StepTableView: UITableView {

    override var intrinsicContentSize: CGSize{
        setNeedsLayout()
        layoutIfNeeded()
        
        return contentSize
    }

}
