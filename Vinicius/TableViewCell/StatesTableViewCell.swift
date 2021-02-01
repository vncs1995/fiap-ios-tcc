//
//  StatesTableViewCell.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 01/02/21.
//

import UIKit

class StatesTableViewCell: UITableViewCell {
    
    static let identifier = "StatesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "StatesTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBAction func didTapButton()  {
        
    }
    
    func configure(with _title: String, _subTitle: String) {
        title.text = _title
        subTitle.text = _subTitle
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
