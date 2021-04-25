//
//  Items.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-23.
//

import Foundation


struct Items: Codable {
    let data: [ItemsData]
    let meta: ItemsMeta
}

struct ItemsData: Codable {
    let id: Int
    let name: String
    let price: Double
    let images: [ItemsImages]
    let seller: ItemsSeller

}

struct ItemsImages: Codable {
    let id: Int
    let small_url, large_url: String
}


struct ItemsSeller: Codable {
    let id: Int
    let username: String
}

struct ItemsMeta: Codable {
    let paging: ItemsMetaPaging
}

struct ItemsMetaPaging: Codable {
    let total_count, page, page_size, total_pages: Int
    let has_next_page: Bool
}

