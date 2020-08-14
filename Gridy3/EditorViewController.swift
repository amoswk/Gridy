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
    var grid: GridView?
    var selectedImage: UIImage?
    var initialCenter = CGPoint()
    var capturedImage: UIImage?
    var storedImage: [UIImage] = []
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imageWindow: UIView!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var startButton: UIView!
    @IBOutlet weak var gridView: UIImageView!
    
 // FUNCTION to Cut Images
    
    
    func imageSlice(image: UIImage, into howManyPieces: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat

        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = image.size.height
            height = image.size.width
        default:
            width = image.size.width
            height = image.size.height
        }

        let tileWidth = Int(width / CGFloat(howManyPieces))
        let tileHeight = Int(height / CGFloat(howManyPieces))

        let scale = Int(image.scale)
        var images = [UIImage]()
        let cgImage = image.cgImage!

        var adjustedHeight = tileHeight

        var y = 0
        for row in 0 ..< howManyPieces {
            if row == (howManyPieces - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< howManyPieces {
                if column == (howManyPieces - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCgImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                images.append(UIImage(cgImage: tileCgImage, scale: image.scale, orientation: image.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }
    
//    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
//    {
////        if let selectedImage = self.selectedImage {
////            var imageViewScale =  max(selectedImage.size.width / viewWidth,
////                                           selectedImage.size.height / viewHeight)
////        }
////
////        else {
////            return nil
////        }
//
//        let imageViewScale = max(inputImage.size.width / viewWidth,
//        inputImage.size.height / viewHeight)
//
//        // Scale cropRect to handle images larger than shown-on-screen size
//        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
//                              y:cropRect.origin.y * imageViewScale,
//                              width:cropRect.size.width * imageViewScale,
//                              height:cropRect.size.height * imageViewScale)
//
//        // Perform cropping in Core Graphics
//        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
//        else {
//            return nil
//        }
//
//        // Return image to UIImage
//        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
//
//
//
//        return croppedImage
//    }
    
    
    
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
            
            self.grid = GridView(frame: self.imageWindow.frame)
            self.grid?.backgroundColor = UIColor.clear
            if let grid = self.grid {
                self.view.addSubview(grid)
            }
            
            
        }
    }
    

    
  
    
    override func viewDidLoad() {
        
      
        
        
        super.viewDidLoad()
        
        
        
        startButton.layer.cornerRadius = 15
        
        imageDisplay.image = selectedImage
        
        
        
   
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    if segue.identifier == "showPuzzleView" {
        
             guard let puzzleVC = segue.destination as? PuzzleView else {
                 return
             }
        
        puzzleVC.gameImage = self.capturedImage
        
         }
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
    
    
    
    
    
    
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.grid?.removeFromSuperview()
        
        //call screenshot function - try to make an extension for captureScreen, self.capturedImage = imageWindow
        //captureScreen(onView: imageWindow)
        if let imageScreenShot = imageWindow?.captureScreen() {
            self.capturedImage = imageScreenShot
            
            performSegue(withIdentifier: "showPuzzleView", sender: nil)
            
        }
        
        //cut picture - find a display mode to show it was cropped correctly
        
    
        if let storedImage = capturedImage?.imageSlice(into: 16) {
            self.storedImage = storedImage
            
            
        //  performSegue(withIdentifier: "showPuzzleView", sender: nil)
            
            }
    
        
        
    
        //pass image array to next view controller
    

        
        //call segue (last)
    
    
        
        
    }
    
}

