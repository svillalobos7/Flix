//
//  DetailViewController.swift
//  Flix
//
//  Created by Stephanie on 11/30/18.
//  Copyright © 2018 Stephanie Villalobos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // UI, UX Variables
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        // Superclass initializer
        super.viewDidLoad()
        
        // Set view parameters for particular movie
        if let movie = movie {
            // The labels
            movieTitleLabel.text = movie.title as String
            releaseDateLabel.text = movie.releaseDate as String
            descriptionLabel.text = movie.overview as String
            // The images
            backdropImageView.af_setImage(withURL: movie.backdropURL!)
            posterImageView.af_setImage(withURL: movie.posterURL!)
        }
        
    }
    
    // Superclass Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
