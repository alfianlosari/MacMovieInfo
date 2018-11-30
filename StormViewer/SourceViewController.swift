//
//  SourceViewController.swift
//  StormViewer
//
//  Created by Alfian Losari on 11/30/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import Cocoa

class SourceViewController: NSViewController {

    @IBOutlet var tableView: NSTableView!
    var repository = MovieRepository.shared
    
    var movies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.fetchMovies(from: .nowPlaying, successHandler: { (response) in
            DispatchQueue.main.async {
                self.movies = response.results
            }
        }) { (error) in
            
        }
        
    }
    
}

extension SourceViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        vw.textField?.stringValue = movies[row].title
        return vw
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else {
            return
        }
        
        guard let splitVC = parent as? NSSplitViewController else {
            return
        }
        
        if let detail = splitVC.children[1] as? DetailViewController {
            detail.movieSelected(movie: movies[tableView.selectedRow])
        }
    }
    
}
