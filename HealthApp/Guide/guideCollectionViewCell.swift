//
//  guideCollectionViewCell.swift
//  HealthApp
//
//  Created by Noah Cooper on 3/4/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit

class guideCollectionViewCell: UICollectionViewCell {
    @IBOutlet var foodImg: UIImageView!
    
    func roundCorners()
    {
        foodImg.layer.cornerRadius = 50
        foodImg.clipsToBounds = true
    }
    
}
