//
//  PhotoController.swift
//  Partager les moments
//
//  Created by Riad Korimbacus on 17/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var partagerBouton: UIBarButtonItem!
    @IBOutlet weak var photoAPartager: UIImageView!
    @IBOutlet weak var texteAPartager: UITextView!
   
    let texteVide = "Entrez un texte ..."
    var imagePicker: UIImagePickerController?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlace()
    }

    func miseEnPlace() {
        
        photoAPartager.contentMode = .scaleAspectFit
        photoAPartager.image = #imageLiteral(resourceName: "Superman-facebook.svg")
        photoAPartager.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(prendrePhoto))
        photoAPartager.addGestureRecognizer(tap)
        
        texteAPartager.text = texteVide
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image: UIImage?
        
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = editee
        } else if let originale = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = originale
        }
        
        photoAPartager.image = image
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    @objc func prendrePhoto() {
        
    }
    
    @IBAction func boutonPartageAppuye(_ sender: Any) {
    }
}
