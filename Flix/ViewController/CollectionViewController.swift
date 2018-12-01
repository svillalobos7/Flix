//
//  CollectionViewController.swift
//  Flix
//
//  Created by Stephanie on 11/30/18.
//  Copyright © 2018 Stephanie Villalobos. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.dataSource = self as UICollectionViewDataSource
        induceProperLayout()
        MovieClient().getNowPlayingMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let index = movieCollectionView.indexPath(for: cell) {
            let newDetailView = segue.destination as! DetailViewController
            newDetailView.movie = movies[index.item]
        }
    }
    
    func induceProperLayout() {
        let layout = movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cellsPerLine : CGFloat = 2
        let interItermSpacingTotal =  layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = movieCollectionView.frame.size.width / cellsPerLine -
            interItermSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
}
