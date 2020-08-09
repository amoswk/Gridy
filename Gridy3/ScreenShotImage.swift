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
    
    func captureScreen(onView: UIView) -> UIImage?
      {
          
          UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0);
          
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
          
          if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
              
              UIGraphicsEndImageContext()
              
              //perform segue
              
              // performSegue(withIdentifier: "showPuzzleView", sender: nil)
              
              
              return image
              
          }
          
          
          return nil
          
          
      }
    
    
    
    
}
