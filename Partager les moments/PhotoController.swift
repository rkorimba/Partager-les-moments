//
//  PhotoController.swift
//  Partager les moments
//
//  Created by Riad Korimbacus on 17/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

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
        
        texteAPartager.delegate = self
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == texteVide {
            textView.text = ""
        }
    }
    
    @objc func prendrePhoto() {
        
        guard imagePicker != nil else { return }

        let alerte = UIAlertController(title: "Prendre photo?", message: "Choisir le média", preferredStyle: .actionSheet)
        
        let appareil = UIAlertAction(title: "Appareil photo", style: .default) { (act) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        
        let librairie = UIAlertAction(title: "Libraire de photos", style: .default) { (act) in
            self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        
        let annuler = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alerte.addAction(appareil)
        alerte.addAction(librairie)
        alerte.addAction(annuler)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = alerte.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
        self.present(alerte, animated: true, completion: nil)
    }
    
    @IBAction func boutonPartageAppuye(_ sender: Any) {
        
        var contenuAPartager: [Any] = [Any]()
        
        if let image = photoAPartager.image, image != #imageLiteral(resourceName: "Superman-facebook.svg") {
            contenuAPartager.append(image)
        }
        
        if texteAPartager.text != "", texteAPartager.text != texteVide {
            contenuAPartager.append(texteAPartager.text)
        }
        
        let activity = UIActivityViewController(activityItems: contenuAPartager, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = activity.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
        self.present(activity, animated: true) {
            self.miseEnPlace()
        }
    }
}
