//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Alfian Losari on 11/30/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {
    
    var movie: Movie! {
        didSet {
            self.imageView.image = nil

        }
    }

    @IBOutlet weak var imageView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func movieSelected(movie: Movie) {
        self.movie = movie
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: movie.backdropURL) else {
                return
            }
            guard let currentMovie = self.movie, currentMovie.id == movie.id else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = NSImage(data: data)
                

            }
        }
        

        
    }
    
    func imageSelected(name: String) {
    }
    
}
