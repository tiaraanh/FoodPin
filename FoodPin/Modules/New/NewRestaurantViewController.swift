//
//  NewRestaurantViewController.swift
//  FoodPinApp
//
//  Created by Tiara H on 22/10/22.
//

import UIKit

class NewRestaurantViewController: UITableViewController {
    
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var completion: (UIImage, String, String, String, String, String) -> Void = { (_, _, _, _, _, _) in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        save()
    }
    
    // access camera after didSelect
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            takePicture()
        }
    }
    
    func save() {
        if let image = imageView.image,
           let name = nameTextField.text, !name.isEmpty,
           let type = typeTextField.text, !type.isEmpty,
           let address = addressTextField.text, !address.isEmpty,
           let phone = phoneTextField.text, !phone.isEmpty,
           let desc = descTextView.text, !desc.isEmpty {
            
            completion(image, name, type, address, phone, desc)
            
            closeButtonTapped(self)
            
        } else {
            
            let alert = UIAlertController(title: "Oops!", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func takePicture() {
        let actionSheet = UIAlertController(title: nil, message: "Choose your photo source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.takePicture(source: .camera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
            self.takePicture(source: .photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    func takePicture(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            return
        }
        
        let viewController = UIImagePickerController()
        viewController.sourceType = source
        viewController.allowsEditing = false
        viewController.delegate = self
        
        present(viewController, animated: true)
    }
}

// MARK: -  UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewRestaurantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        }
        dismiss(animated: true)
    }
}

