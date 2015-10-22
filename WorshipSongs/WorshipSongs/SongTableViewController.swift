//
//  FruitsTableViewController.swift
//  TableExample
//
//  Created by Ralf Ebert on 27/04/15.
//  Copyright (c) 2015 Example. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var songs = [Song]()
    var filteredTableData = [Song]()
    var resultSearchController = UISearchController()
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songs = [Song(title:"Chocolate", lyrics:"chocolate Bar"),
            Song(title:"Chocolate", lyrics:"chocolate Chip"),
            Song(title:"Chocolate", lyrics:"dark chocolate"),
            Song(title:"Hard", lyrics:"lollipop"),
            Song(title:"Hard", lyrics:"candy cane"),
            Song(title:"Hard", lyrics:"jaw breaker"),
            Song(title:"Other", lyrics:"caramel"),
            Song(title:"Other", lyrics:"sour chew"),
            Song(title:"Other", lyrics:"gummi bear")]
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
            cell.textLabel?.text = filteredTableData[indexPath.row].title
            return cell
        }
        else{
            cell.textLabel?.text = songs[indexPath.row].title
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
        
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText!)
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        if(searchText == "")
        {
            filteredTableData = songs
        }
        else
        {
            // Assuming `Author` as Class Or you may use any other method for filtering data
            filteredTableData = songs.filter({ ( a: Song) -> Bool in
                
                let nameMatch = a.title.rangeOfString(searchText, options:
                    NSStringCompareOptions.CaseInsensitiveSearch)
                return nameMatch != nil
            })
            
        }
    }
}