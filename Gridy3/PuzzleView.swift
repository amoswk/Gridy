//
//  PuzzleView.swift
//  Gridy3
//
//  Created by Amos Katz on 7/15/20.
//  Copyright © 2020 Amos Katz. All rights reserved.
//

import Foundation
import UIKit





var image: UIImage = UIImage()


class PuzzleView: UIViewController {
    //Variables for PuzzleView
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBOutlet weak var gameImageView: UIImageView!
    var gameImage: UIImage?
    
    // self.gameImage = storedImage
    
    func configureLaylout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        
        return UICollectionViewCompositionalLayout(section: section)
        
        
        

        
    }
    
    
    
    
    @IBAction func startGame(_ sender: Any) {
        
        
        
        
        
        
     }
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
        gameImageView.image = image
            
            collectionView.collectionViewLayout = configureLaylout()
            
            
            
    }
    
    
}



