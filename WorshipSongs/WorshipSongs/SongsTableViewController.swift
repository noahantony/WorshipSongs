//
//  FruitsTableViewController.swift
//  TableExample
//
//  Created by Ralf Ebert on 27/04/15.
//  Copyright (c) 2015 Example. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {
    
    var songs = ["Jesus is my Lord", "Kartharai Thuthipom"]
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath)
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    /*override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let movedObject = self.songs[sourceIndexPath.row]
        songs.removeAtIndex(sourceIndexPath.row)
        songs.insert(movedObject, atIndex: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(songs)")
        // To check for correctness enable:  self.tableView.reloadData()
    }*/
    
    
}