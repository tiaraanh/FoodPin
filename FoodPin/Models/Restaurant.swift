//
//  Restaurant.swift
//  FoodPinApp
//
//  Created by Tiara H on 23/10/22.
//

import UIKit
import MapKit

class Restaurant {
    var name: String
    var category: String
    var address: String
    var phone: String
    var description: String
    var thumb: UIImage
    var rating: Rating?
    var latitude: Double
    var longitude: Double
    
    init(name: String, category: String, address: String, phone: String, description: String, thumb: UIImage, rating: Rating? = nil, latitude: Double, longitude: Double) {
        self.name = name
        self.category = category
        self.address = address
        self.phone = phone
        self.description = description
        self.thumb = thumb
        self.rating = rating
        self.latitude = latitude
        self.longitude = longitude
    }
}
