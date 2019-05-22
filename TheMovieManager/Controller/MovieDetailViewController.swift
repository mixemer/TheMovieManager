//
//  MovieDetailViewController.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    var movie: Movie!
    
    var isWatchlist: Bool {
        return MovieModel.watchlist.contains(movie)
    }
    
    var isFavorite: Bool {
        return MovieModel.favorites.contains(movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.title
        
        toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        
        imageView.image = UIImage(named: "PosterPlaceholder")
        
        if let poster = movie.posterPath {
            TMDBClient.getImage(imgURL: poster) { (image, error) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
    }
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        let body = MarkWatchlist(mediaType: "movie", mediaId: movie.id, watchlist: !isWatchlist)
        TMDBClient.addWatchlist(body: body) { (success, error) in
            if success {
                self.toggleBarButton(sender, enabled: !self.isWatchlist)
            } else {
                print("error= ", error ?? "")
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        let body = MarkFavorite(mediaType: "movie", mediaId: movie.id, favorite: !isFavorite)
        TMDBClient.addFavorite(body: body) { (success, error) in
            if success {
                self.toggleBarButton(sender, enabled: !self.isFavorite)
            } else {
                print("error= ", error ?? "")
            }
        }
    }
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }
    
    
}
