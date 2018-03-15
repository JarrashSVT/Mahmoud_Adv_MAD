//
//  MainTableViewController_search.swift
//  Mahmoud_Midterm
//
//  Created by Mahmoud Aljarrash on 3/15/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//


import UIKit

extension MainTableViewController : UISearchResultsUpdating
{
    
    func updateSearchResults(for searchController: UISearchController)
    {
        searchController.searchResultsController?.view.isHidden = false
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool
    {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All")
    {
        
        filteredRestaurants =  restaurants!.filter({ (r: Restaurant) -> Bool in
            return r.name.lowercased().contains(searchText.lowercased())
            
        })
        tableView?.reloadData()
    }
    
    func isFiltering() -> Bool
    {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
