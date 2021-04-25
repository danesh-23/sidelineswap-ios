//
//  SearchBar.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-24.
//

import Foundation
import UIKit


class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchBar()
    }
    
    func configureSearchBar() {
        self.sizeToFit()
        self.placeholder = "Search for any product you want"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
