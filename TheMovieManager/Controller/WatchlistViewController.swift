//
//  WatchlistViewController.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = TMDBClient.getWatchlist() { movies, error in
            MovieModel.watchlist = movies
            self.tableView.reloadData()
        }
        
        tableView.refreshControl = refresher
        
    }
    
    @objc func refresh() {
        _ = TMDBClient.getWatchlist() { movies, error in
            MovieModel.watchlist = movies
            self.tableView.reloadData()
        }
        
        let deadline = DispatchTime.now() + .milliseconds(800)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresher.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController
            detailVC.movie = MovieModel.watchlist[selectedIndex]
        }
    }
    
}

extension WatchlistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let movie = MovieModel.watchlist[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.imageView?.image = UIImage(named: "PosterPlaceholder")
        
        if let poster = movie.posterPath {
            TMDBClient.getImage(imgURL: poster) { (image, error) in
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
