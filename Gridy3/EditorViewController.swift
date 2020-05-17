//
//  EditorViewController.swift
//  GRIDYNEW
//
//  Created by Amos Katz on 4/19/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import Foundation
import UIKit

class EditorViewController: UIViewController {
    
    
    //Variables for EditorViewController
    var selectedImage: UIImage?
    var initialCenter = CGPoint()
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imageWindow: UIView!
    @IBOutlet weak var imageDisplay: UIImageView!
    
    
    
    
    // FUNCTION for creating the window through the blur
    
    func setMask(with hole: CGRect, in view: UIView){
        
        
        let mutablePath = CGMutablePath()
        mutablePath.addRect(view.bounds)
        mutablePath.addRect(hole)
        
        
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = CAShapeLayerFillRule.evenOdd
        
        
        view.layer.mask = mask
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     imageDisplay.image = selectedImage

    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//
////                imageDisplay.image = selectedImage
////
////                so the blur view window loads on app startup
//
//               let squareWindow = imageWindow.frame.integral
//
//               // for setting the mask in the created view
//               setMask(with: squareWindow, in: blurView!)
        
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {

        
 
        
        
        
        
        // so the blur view window loads on app startup

//        let squareWindow = imageWindow.frame.integral
        
        let squareWindow = blurView.convert(imageWindow.frame, to: blurView)

               // for setting the mask in the created view
               setMask(with: squareWindow, in: blurView!)
        
        
 // find coordinates of mask, then draw lines
        
//Place drawing here - after "setMask"
        
        
        
    }

    
    
    
    
    //GESTURE Functions - Pinch, Pan, and Rotate
    
    
    @IBAction func imagePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard imageDisplay != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            imageDisplay.transform = (imageDisplay.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))
            gestureRecognizer.scale = 1.0
        }
        
    }
    
    
    
    
    @IBAction func imagePan(_ gestureRecognizer : UIPanGestureRecognizer) {
        guard imageDisplay != nil else {return}
        let piece = imageDisplay
        
        let translation = gestureRecognizer.translation(in: piece?.superview)
        if gestureRecognizer.state == .began {
            
            self.initialCenter = piece!.center
        }
        
        if gestureRecognizer.state != .cancelled {
            
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece?.center = newCenter
        }
        else {
            
            piece?.center = initialCenter
        }
    }
    
    
    
    
    @IBAction func imageRotate(_ gestureRecognizer : UIRotationGestureRecognizer) {
        guard imageDisplay != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            imageDisplay.transform = imageDisplay.transform.rotated(by: gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    
}
