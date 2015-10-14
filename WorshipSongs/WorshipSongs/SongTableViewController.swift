//
//  FruitsTableViewController.swift
//  TableExample
//
//  Created by Ralf Ebert on 27/04/15.
//  Copyright (c) 2015 Example. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var songs = ["Jesus is my Lord", "Kartharai Thuthipom"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        self.resultSearchController = ({let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.resultSearchController.active){
            return self.filteredTableData.count
        }
        else {
            return self.songs.count
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if(self.resultSearchController.active){
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        }
        else{
            cell.textLabel?.text = songs[indexPath.row]
            return cell
            
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (songs as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    /*override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    let movedObject = self.songs[sourceIndexPath.row]
    songs.removeAtIndex(sourceIndexPath.row)
    songs.insert(movedObject, atIndex: destinationIndexPath.row)
    NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(songs)")
    // To check for correctness enable:  self.tableView.reloadData()
    }*/
    
    
}