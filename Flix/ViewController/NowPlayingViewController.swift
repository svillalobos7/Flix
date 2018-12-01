//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Stephanie on 11/30/18.
//  Copyright © 2018 Stephanie Villalobos. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    // UI, UX Variables
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Backend Variables
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        // Superclass initializer
        super.viewDidLoad()
        
        // Setup pull-to-refresh functionality
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.pullToRefresh(_:)), for: .valueChanged)
        movieTableView.insertSubview(refreshControl, at: 0)
        
        // Properly source and align table view
        movieTableView.dataSource = self as UITableViewDataSource
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = 50
        
        // Make a network request
        activityIndicator.startAnimating()
        // getNowPlayingMovies()
        MovieClient().getNowPlayingMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.movieTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // Resend the network request upon pull
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        MovieClient().getNowPlayingMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.movieTableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let index = movieTableView.indexPath(for: cell) {
            let newDetailView = segue.destination as! DetailViewController
            newDetailView.movie = movies[index.row]
        }
    }
    
    // Superclass methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Protocol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve JSON information
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        // Activate property observer in MovieCell class
        cell.movie = movies[indexPath.row]
        return cell
    }
    
}
