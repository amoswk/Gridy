//
//  CaptureImage.swift
//  Gridy3
//
//  Created by Amos on 8/9/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    func takeScreenshot(rect: CGRect) -> UIImage {
        
        //begin
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        
        // draw view in that context.
        self.drawHierarchy(in: rect, afterScreenUpdates: true)
        
        // get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            return image!
        }
        
        return UIImage()
        
    }
    
}





