//
//  ItemsCellViewModel.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-23.
//

import Foundation


class ItemsCellViewModel {
    
    var item: ItemsData
    var refreshClosure: (() -> ())?
    var removeLoadingClosure: (() -> ())?
    
    init(item: ItemsData, refreshCallback: @escaping () -> (), removeScreenCallback: @escaping () -> ()) {
        self.item = item
        self.refreshClosure = refreshCallback
        self.removeLoadingClosure = removeScreenCallback
        createImage()
    }
    
    var itemTitle: String { return item.name }
    var price: String { return item.price.description }
    var seller: String { return item.seller.username }
    var image: String { return item.images.first!.small_url }
    
    var itemImageData: Data? {
        didSet {
            guard let refresh = refreshClosure, let removeLoading = removeLoadingClosure else { return }
            refresh(); removeLoading()
        }
    }
    
    private func createImage() {
        guard let url = URL(string: image) else { print("cant convert to url"); return }
        if let cachedImage = CacheManager.shared.retrieveData(for: NSString(string: url.absoluteString)) {
            itemImageData = cachedImage as Data
        } else {
            WebServices().downloadImage(url: url) { [weak self] (data) in
                if let data = data {
                    // downloaded images from url successfully
                    self?.itemImageData = data
                    CacheManager.shared.addData(for: NSString(string: url.absoluteString), with: data as NSData)
                }
            }
        }

    }
    
}
