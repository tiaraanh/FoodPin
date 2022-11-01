//
//  RestaurantViewCell.swift
//  FoodPinApp
//
//  Created by Tiara H on 20/10/22.
//

import UIKit

class RestaurantViewCell: UITableViewCell {

    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        
    }
    
    func setup() {
        thumbImageView.layer.cornerRadius = 20
        thumbImageView.layer.masksToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
