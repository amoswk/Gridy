//
//  GridView.swift
//  Gridy3
//
//  Created by Amos Katz on 7/5/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    override func draw(_ rect: CGRect)
    {
        
        var bezierPath = UIBezierPath()
        bezierPath.lineWidth = 5.0
        for index in 1...3 {
            
            let start = CGPoint(x: CGFloat(index) * self.bounds.width/4, y: 0)
            let end = CGPoint(x: CGFloat(index) * self.bounds.width/4, y: self.bounds.height)
            
            let start2 = CGPoint(x: 0, y: CGFloat(index) * self.bounds.height/4)
            let end2 = CGPoint(x: self.bounds.width, y: CGFloat(index) * self.bounds.height/4)
            
            
            bezierPath.move(to: start)
            bezierPath.addLine(to: end)
            bezierPath.move(to: start2)
            bezierPath.addLine(to: end2)
            
        }
        
        bezierPath.close()
        
        
        UIColor.red.setStroke()
        
        
        bezierPath.stroke()
        
        
    }
}
