//
//  EventsCollectionViewController_Search.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 3/6/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit


extension EventsCollectionViewController : UISearchResultsUpdating
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

        filteredEvents =  events.filter({ (event: Event) -> Bool in
            return event.title.lowercased().contains(searchText.lowercased())
                || event.campus.lowercased().contains(searchText.lowercased())
            
        })
        collectionView?.reloadData()
    }
    
    func isFiltering() -> Bool
    {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
