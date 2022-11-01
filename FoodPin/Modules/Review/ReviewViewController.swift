//
//  ReviewViewController.swift
//  FoodPinApp
//
//  Created by Tiara H on 23/10/22.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var ratebuttons: [UIButton]! {
        didSet {
            ratebuttons.forEach { button in
                button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            }
        }
    }
    
    @IBOutlet var closeButton: UIButton!
    
    var backgroundImage: UIImage!
    var completion: (Rating) -> Void = { (_) in }
    

    override func viewDidLoad() {
        super.viewDidLoad()

         
        backgroundImageView.image = backgroundImage
        
        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        let moveUpTransform = CGAffineTransform.init(translationX: 0, y: -600)
        
        // Make the button invisible and move off the screen
        for rateButton in ratebuttons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        closeButton.transform = moveUpTransform
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        for index in 0...4 {
            UIView.animate(withDuration: 0.4, delay: (0.1 + 0.05 * Double(index)), options: [], animations: {
                self.ratebuttons[index].alpha = 1.0
                self.ratebuttons[index].transform = .identity
            }, completion: nil)
        }
        
        // Animate the close button
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.closeButton.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        let rating = Rating(rawValue: sender.tag) ?? .okay
        dismiss(animated: true) {
            self.completion(rating)
        }
    }
}

extension UIViewController {
    func presentReviewViewController(backgroundImage: UIImage, completion: @escaping (Rating) -> Void) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "review") as! ReviewViewController
        viewController.backgroundImage = backgroundImage
        viewController.completion = completion
        present(viewController, animated: true)
        
    }
}


