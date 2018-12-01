//
//  PosterCell.swift
//  Flix
//
//  Created by Stephanie on 11/30/18.
//  Copyright © 2018 Stephanie Villalobos. All rights reserved.
//

import UIKit
class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            posterImageView.af_setImage(withURL: movie.posterURL!)
        }
    }
    
}
