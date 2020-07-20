//
//  ViewController.swift
//  GRIDYNEW
//
//  Created by Amos Katz on 3/15/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    let imgArray = [UIImage(named: "img1"), UIImage(named: "img2"), UIImage(named: "img3"), UIImage(named: "img4"), UIImage(named: "img5"), UIImage(named: "img6")].shuffled()
    var selectedImage = UIImage()
    
    
    
    
    
    
    
    @IBOutlet weak var challengeLabel: UILabel!
    
    @IBOutlet weak var gridyLabel: UILabel!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var libraryButton: UIButton!
    
    @IBOutlet weak var gridyButton: UIButton!
    
    

    //
    
    
    
 
        
    
    override func viewDidLoad() {
        
        
       
        
        
        
        super.viewDidLoad()
        
        
        cameraButton.layer.cornerRadius = 15
        libraryButton.layer.cornerRadius = 15
        gridyButton.layer.cornerRadius = 15
        
        
        
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
    }
    
    
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
        
             if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
        let actionOne = UIAlertController(title: "Photo Source", message: "Take a Photo", preferredStyle: .actionSheet)
        actionOne.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { (action:UIAlertAction) in self.imagePicker.sourceType = .camera
            
        
                
                self.present(self.imagePicker, animated: true, completion: nil)
                
           
            
            
        }))
        
        
        self.present(actionOne, animated: true, completion: nil)
         }
    }
    
    @IBAction func libraryButtonTouched(_ sender: Any) {
        
        
        
        let actionTwo = UIAlertController(title: "Photo Source", message: "Choose a Photo", preferredStyle: .actionSheet)
        actionTwo.addAction(UIAlertAction(title: "Open Library", style: .default, handler: { (action:UIAlertAction) in self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }))
        
        
        self.present(actionTwo, animated: true, completion: nil)
        
        
    }
    
    
    // imagePickerController funciton allows camera or library image to move to next view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Selected Image")
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            
            return }
        
        self.selectedImage = selectedImage
        performSegue(withIdentifier: "showEditorView", sender: nil)
        
    }
    
    
    
    
    
    @IBAction func gridyPickButtonTouched(_ sender: Any) {
        
        
        guard let firstImage = imgArray.shuffled().first, let image = firstImage else {
            return
        }
        
        self.selectedImage = image
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //using an identifier to identify the segue, named "showEditorView"
        
        if segue.identifier == "showEditorView" {
            guard let editorVC = segue.destination as? EditorViewController else {
                return
            }
            editorVC.selectedImage = self.selectedImage
        }
        
        
        
    }
    
    
    
}
