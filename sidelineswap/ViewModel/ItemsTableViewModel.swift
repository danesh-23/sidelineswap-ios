//
//  ItemsTableViewModel.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-23.
//

import Foundation


class ItemsTableViewModel {
    
    let webServices: WebServices = WebServices()

    var itemsCellVM: [ItemsCellViewModel] = []
    var filtered: [ItemsCellViewModel] = [] {
        didSet {
            guard let refresh = refreshTableBinding else { return }
            refresh()
        }
    }
    
    var refreshTableBinding: (() -> ())?
    var removeLoadingScreenBinding: (() -> ())?
    var showAlert: ((String) -> ())?
    
    var numberOfSections: Int { return 2 }
    var currentPage: Int = 1
    var hasNextPage: Bool = true
    var isCurrentlyFetching: Bool = false
    var lastSearch: String = "Nike Bag"
    
    
    func numberOfRowsForSection(at section: Int) -> Int {
        if section == 0 {
            return filtered.count == 0 ? itemsCellVM.count: filtered.count
        } else if section == 1 && isCurrentlyFetching {
            return 1
        }
        return 0
    }
    
    func populateData(search: String = "Nike Bag") {
        
        if !isCurrentlyFetching && hasNextPage {
            isCurrentlyFetching = true
            guard let url = Constants.apiURL(item: search, page: currentPage) else { return }
            webServices.callItemsAPI(url: url) { [weak self] (result: Result<Items, Error>) in
                guard let self = self else { return }
                self.isCurrentlyFetching = false
                switch result {
                case.success(let items):
                    let itemDatas = items.data
                    self.validateNextPage(meta: items.meta.paging)
                    
                    guard let refresh = self.refreshTableBinding, let removeScreen = self.removeLoadingScreenBinding else { return }
                    
                    if search != self.lastSearch {
                        if itemDatas.count == 0 {
                            guard let alert = self.showAlert else { return }
                            alert("There are no search results for \(search)")
                        } else {
                            self.itemsCellVM = itemDatas.map { ItemsCellViewModel(item: $0, refreshCallback: refresh, removeScreenCallback: removeScreen) }
                            self.lastSearch = search
                        }

                    } else {
                        self.itemsCellVM.append(contentsOf: itemDatas.map { ItemsCellViewModel(item: $0, refreshCallback: refresh, removeScreenCallback: removeScreen) })
                    }
                    refresh()
                    
                case .failure(let error):
                    guard let showAlert = self.showAlert else { return }
                    showAlert(error.localizedDescription.replacingOccurrences(of: ".", with: ""))
                }
            }
        }
    }
    
    func validateNextPage(meta: ItemsMetaPaging) {
        if meta.has_next_page {
            currentPage += 1
        }
        hasNextPage = meta.has_next_page
    }
    
    func itemForRowAt(at row: Int) -> ItemsCellViewModel {
        return filtered.count > 0 ? self.filtered[row] : self.itemsCellVM[row]
    }
    
    func searchFieldEntered(searchText: String) {
        filtered = itemsCellVM.filter({ (item) -> Bool in
            return item.itemTitle.contains(searchText)
        })
    }
    
    func searchBarEntered(searchText: String) {
        if filtered.count == 0 {
            if lastSearch != searchText {
                currentPage = 1
                hasNextPage = true
                populateData(search: searchText)
            }
        }
    }
    
}

