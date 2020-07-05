//
//  GridDraw.swift
//  Gridy3
//
//  Created by Amos Katz on 6/4/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import Foundation
import UIKit

//class GridView: UIView
//{
//    var path = UIBezierPath()
//    var gridWidthLines: CGFloat
//    
//    {
//        return 3
//    }
//   var gridHeightLines: CGFloat
//    {
//        return 3
//    }
//
//   var gridWidth: CGFloat
//    {
//        return bounds.width/CGFloat(gridWidthLines)
//    }
//
//   var gridHeight: CGFloat
//    {
//        return bounds.height/CGFloat(gridHeightLines)
//    }
//
//    var gridCenter: CGPoint {
//        return CGPoint(x: bounds.midX, y: bounds.midY)
//    }
//
//    func drawGrid()
//    {
//        path = UIBezierPath()
//        path.lineWidth = 5.0
//
//        for index in 1...Int(gridWidthLines) - 1
//        {
//            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
//            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
//            let start2 = CGPoint(x: 0, y: CGFloat(index) * gridHeight)
//            let end2 = CGPoint(x:bounds.height, y: CGFloat(index) * gridHeight)
//            path.move(to: start)
//            path.addLine(to: end)
//        }
//        //Close the path.
//        path.close()
//
//    }
//
//    override func draw(_ rect: CGRect)
//    {
//        drawGrid()
//
//        UIColor.blue.setStroke()
//        path.stroke()
//    }
//}
