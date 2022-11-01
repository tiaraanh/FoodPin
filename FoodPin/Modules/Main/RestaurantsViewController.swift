//
//  RestaurantViewController.swift
//  FoodPinApp
//
//  Created by Tiara H on 20/10/22.
//

import UIKit

class RestaurantsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: RestaurantsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addRestaurant()
    }
}

// MARK: - Helpers
extension RestaurantsViewController {
    func setup() {
        viewModel = RestaurantsViewModel(delegate: self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addRestaurant() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "navNewRestaurant") as! UINavigationController
        let vc = nv.viewControllers.first as! NewRestaurantViewController
        
        vc.completion = { (image, name, type, address, phone, desc) in
            self.viewModel.addRestaurant(name: name, category: type, address: address, phone: phone, description: desc, thumb: image, latitude: 41.8902, longitude: 12.4922)
        }
        
        present(nv, animated: true)
    }
    
    func rateRestaurant(at index: Int) {
        let thumb = viewModel.restaurantThumb(at: index)
        presentReviewViewController(backgroundImage: thumb) { (rating) in
            self.viewModel.rateRestaurant(at: index, rating: rating)
        }
    }
}
// MARK: - RestaurantViewModelDelegate
extension RestaurantsViewController: RestaurantViewModelDelegate {
    func restaurantsDidUpdate() {
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension RestaurantsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRestaurants
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeShopCellId", for: indexPath) as! RestaurantViewCell
        
        let index = indexPath.row
        cell.thumbImageView.image = viewModel.restaurantThumb(at: index)
        cell.ratingImageView.image = viewModel.restaurantRating(at: index)?.image
        cell.nameLabel.text = viewModel.restaurantName(at: index)
        cell.addressLabel.text = viewModel.restaurantAddress(at: index)
        cell.categoryLabel.text = viewModel.restaurantCategory(at: index)
        
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let details = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailRestaurantViewController {
            
            let index = indexPath.row
            details.imageViews = viewModel.restaurantThumb(at: index)
            details.name = viewModel.restaurantName(at: index)
            details.location = viewModel.restaurantAddress(at: index)
            details.type = viewModel.restaurantCategory(at: index)
            details.descriptions = viewModel.restaurantDescription(at: index)
            details.phone = viewModel.restaurantPhone(at: index)
            details.latitude = viewModel.restaurantLatitude(at: index)
            details.longitude = viewModel.restaurantLongitude(at: index)
            
            self.navigationController?.pushViewController(details, animated: true)
        }
        
//        rateRestaurant(at: indexPath.row)
    }
}
