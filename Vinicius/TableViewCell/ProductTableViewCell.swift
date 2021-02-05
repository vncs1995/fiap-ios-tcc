//
//  ProductTableViewCell.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 01/02/21.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func didTapCell(with product: Product)
}

class ProductTableViewCell: UITableViewCell {
    
    weak var delegate: ProductTableViewCellDelegate?
    static let identifier = "ProductTableViewCell"
    private var product: Product?
    
    @IBOutlet weak var cellButton: UIButton!
    static func nib() -> UINib {
        return UINib(nibName: "ProductTableViewCell", bundle: nil)
    }
    
    @IBAction func didTapCell(_ sender: Any) {
        delegate?.didTapCell(with: self.product!)
    }
    
    
    func configureProduct(with product: Product) {
        self.product = product
        cellButton.setTitle(product.name, for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
