//
//  ViewController.swift
//  CustomCollectionViewSample
//
//  Created by Максим Окунеев on 2/11/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    var numbers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...20 {
            numbers.append(i)
        }
    }
}

//MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as?  CustomCollectionViewCell else { return UICollectionViewCell() }
        
        
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        cell.numberLabel.text = String(numbers[indexPath.item])
        
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}
