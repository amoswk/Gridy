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
    @IBOutlet weak var startButton: UIView!
    @IBOutlet weak var gridView: UIImageView!
    
    
    
    // FUNCTION for creating the window through the blur
        
   func setMask(){
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.imageDisplay.isHidden = false
                let squareWindow = self.blurView.convert(self.imageWindow.frame, to: self.blurView)
                let mutablePath = CGMutablePath()
                mutablePath.addRect(self.blurView.bounds)
                mutablePath.addRect(squareWindow)
                
                
                let mask = CAShapeLayer()
                mask.path = mutablePath
                mask.fillRule = CAShapeLayerFillRule.evenOdd
                
                
                self.blurView.layer.mask = mask
                self.imageDisplay.clipsToBounds = false
                
                // code to draw lines
              
                

                
                
                let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 500))
                let img1 = renderer1.image { ctx in
                    
                    ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
                    ctx.cgContext.setLineWidth(3)
              
                    
                    ctx.cgContext.move(to: CGPoint(x: 500/3, y: 500/3))
                    ctx.cgContext.addLine(to: CGPoint(x: 0, y: 500))
                  
                   
                    
            
                    
                    let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
                    ctx.cgContext.addRect(rectangle)
                    ctx.cgContext.drawPath(using: .fillStroke)
                    
                    
                    
                    
                  
                }
                
               let gridView = UIImageView(frame: squareWindow)
                
                
                
                gridView.backgroundColor = .clear
                
                gridView.image = img1
                
                self.imageWindow.addSubview(gridView)
                
            }
    
    
            
        }
    
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        
        startButton.layer.cornerRadius = 15
        
        imageDisplay.image = selectedImage
        
    }
    
    
    
        override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
    

                  
    
                   // for setting the mask in the created view
                   setMask()
    
    
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

