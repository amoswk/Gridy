//
//  UIImage+ImageSlice.swift
//  Gridy3
//
//  Created by Amos on 8/2/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    func imageSlice(into howManyPieces: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat

        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = self.size.height
            height = self.size.width
        default:
            width = self.size.width
            height = self.size.height
        }

        let tileWidth = Int(width / CGFloat(howManyPieces))
        let tileHeight = Int(height / CGFloat(howManyPieces))

        let scale = Int(self.scale)
        var images = [UIImage]()
        let cgImage = self.cgImage!

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
                images.append(UIImage(cgImage: tileCgImage, scale: self.scale, orientation: self.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }
}
