//
//  ItemsCell.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-23.
//

import UIKit

class ItemsCell: UITableViewCell {

    static let identifier: String = "ItemsCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupImages()
    }
    
    private func setupImages() {
        self.itemImageView.layer.masksToBounds = true
        self.itemImageView.layer.cornerRadius = 0.05 * self.itemImageView.bounds.height
        self.itemImageView.layer.borderColor = UIColor.black.cgColor
        self.itemImageView.layer.borderWidth = 1
    }
    
    func configureCell(vm: ItemsCellViewModel) {
        self.titleLabel.text = vm.itemTitle
        vm.itemImageData == nil ? nil : (self.itemImageView.image = UIImage(data: vm.itemImageData!))
        self.priceLabel.text = "$\(vm.price)"
        self.sellerLabel.text = vm.seller
    }
}
