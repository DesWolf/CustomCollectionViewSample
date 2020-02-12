//
//  CustomCollectionViewLayout.swift
//  CustomCollectionViewSample
//
//  Created by Максим Окунеев on 2/11/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {

    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        guard cache.isEmpty == true, let collectionView = collectionView else {return}
       
        var xOffset = [CGFloat]()
        var yOffset = [CGFloat]()
        var firstRadius = contentWidth / 4
        var secondRadius = firstRadius * 0.9
        var column = 0
       
        for item in 0..<collectionView.numberOfItems(inSection: 0){
       
        let indexPath = IndexPath(item: item, section: 0)
            
            if column == 0 {
                if firstRadius == contentWidth / 4 {
                    xOffset.append(0)
                    yOffset.append(0)
                } else {
                    xOffset.append(contentWidth / 2 - 2 * firstRadius)
                    yOffset.append((yOffset.last ?? 0)! + 2 * secondRadius)
                }
            } else if column == 1 {
                xOffset.append((xOffset.last ?? 0)! + 2 * secondRadius)
                yOffset.append((yOffset.last ?? 0)! + 2 * secondRadius)
            }
       
        let frame = CGRect(x: (xOffset.last ?? 0)!, y: (yOffset.last ?? 0)!, width: 2 * firstRadius, height: 2 * firstRadius)
        
        print("frame: \(frame)")
        
        let insetFrame = frame.insetBy(dx: 1, dy: 1)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)

        contentHeight = max(collectionView.frame.height + 10, frame.maxY)
        
        firstRadius = secondRadius
        secondRadius *= 0.9
        

        if column == 0{
            column = 1
        } else {
            column = 0
        }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}

