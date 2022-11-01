//
//  Rating.swift
//  FoodPinApp
//
//  Created by Tiara H on 23/10/22.
//

import UIKit

enum Rating: Int {
    case terrible = 1
    case bad = 2
    case okay = 3
    case good = 4
    case awesome = 5
    
    var image: UIImage {
        switch self {
        case .terrible:
            return UIImage(named: "icn_angry")!
        case .bad:
            return UIImage(named: "icn_sad")!
        case .okay:
            return UIImage(named: "icn_cool")!
        case .good:
            return UIImage(named: "icn_happy")!
        case .awesome:
            return UIImage(named: "icn_love")!
        }
    }
}

