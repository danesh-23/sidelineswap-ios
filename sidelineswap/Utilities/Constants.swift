//
//  Constants.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-24.
//

import Foundation


struct Constants {
    static func apiURL(item: String, page: Int) -> URL? {
        guard let url = URL(string: "https://api.staging.sidelineswap.com/v1/facet_items?q=\(item.replacingOccurrences(of: " ", with: "%20").lowercased())&page=\(page)") else { print("invalid url"); return nil }
        return url
    }
    
    static let exampleItems: [Items] = [Items(data: [ItemsData(id: 1234, name: "Nike Shoe Bag", price: 24, images: [ItemsImages(id: 3353, small_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520", large_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520")], seller: ItemsSeller(id: 537838, username: "dannyb0yy_23"))], meta: ItemsMeta(paging: ItemsMetaPaging(total_count: 50, page: 1, page_size: 20, total_pages: 3, has_next_page: true))), Items(data: [ItemsData(id: 1234, name: "Nike Shoe Bag", price: 24, images: [ItemsImages(id: 3353, small_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520", large_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520")], seller: ItemsSeller(id: 537838, username: "dannyb0yy_23"))], meta: ItemsMeta(paging: ItemsMetaPaging(total_count: 50, page: 1, page_size: 20, total_pages: 3, has_next_page: true))), Items(data: [ItemsData(id: 1234, name: "Nike Shoe Bag", price: 24, images: [ItemsImages(id: 3353, small_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520", large_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520")], seller: ItemsSeller(id: 537838, username: "dannyb0yy_23"))], meta: ItemsMeta(paging: ItemsMetaPaging(total_count: 50, page: 1, page_size: 20, total_pages: 3, has_next_page: true))), Items(data: [ItemsData(id: 1234, name: "Tester", price: 24, images: [ItemsImages(id: 3353, small_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520", large_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520")], seller: ItemsSeller(id: 537838, username: "dannyb0yy_23"))], meta: ItemsMeta(paging: ItemsMetaPaging(total_count: 50, page: 1, page_size: 20, total_pages: 3, has_next_page: true))), Items(data: [ItemsData(id: 1234, name: "Nike Shoe Bag", price: 24, images: [ItemsImages(id: 3353, small_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520", large_url: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333114626_81_a-Nike-Shoe-Box-Bag-BA6149-810?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520")], seller: ItemsSeller(id: 537838, username: "dannyb0yy_23"))], meta: ItemsMeta(paging: ItemsMetaPaging(total_count: 50, page: 1, page_size: 20, total_pages: 3, has_next_page: true)))]

}


