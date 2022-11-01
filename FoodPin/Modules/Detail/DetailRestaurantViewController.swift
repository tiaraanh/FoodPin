//
//  DetailViewController.swift
//  FoodPinApp
//
//  Created by Tiara H on 21/10/22.
//

import UIKit
import MapKit

class DetailRestaurantViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var rateButton: UIButton!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    var viewModel: RestaurantsViewModel!
    
    var imageViews = UIImage()
    var name = ""
    var type = ""
    var location = ""
    var descriptions = ""
    var phone = ""
    var latitude: Double!
    var longitude: Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        render()
    }
    
    
    @IBAction func ratedButtonTapped(_ sender: Any) {
        favorite()
    }
    
    
    func favorite() {
        self.favoriteImageView.isHidden = self.favoriteImageView.isHidden ? false : true
        dismiss(animated: true)
    }
    
    func setup() {
        
        rateButton.layer.cornerRadius = 20
        rateButton.layer.masksToBounds = true
        
        mapView.layer.cornerRadius = 20
        mapView.layer.masksToBounds = true
        
        mapView.isScrollEnabled = false
        mapView.delegate = self
        
        titleLabel.text = name
        subtitleLabel.text = type
        imageView.image = imageViews
        addressLabel.text = location
        descLabel.text = descriptions
        phoneLabel.text = phone
    }
    
    func render() {
    
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let annoation = MKPointAnnotation()
    annoation.coordinate = coordinate
    mapView.addAnnotation(annoation)
    
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
    mapView.setRegion(region, animated: true)
    mapView.setRegion(region, animated: true)
        
    }
}
    
    
// MARK: - MKMapViewDelegate
extension DetailRestaurantViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
        routeToPlace()
    }

    func routeToPlace() {
        let actionSheet = UIAlertController(title: "Directions using", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Maps", style: .default, handler: { (_) in
            self.openMaps()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }

    func openMaps() {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])

    }
}


