//
//  ViewController.swift
//  BJAutoScrollingCollectionViewExample
//
//  Created by BadhanGanesh on 15/01/18.
//  Copyright © 2018 Badhan Ganesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: BJAutoScrollingCollectionView! //Step 1
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    let imagesArray = [#imageLiteral(resourceName: "BlueDrop"), #imageLiteral(resourceName: "GreenDrops"), #imageLiteral(resourceName: "HouseFly"), #imageLiteral(resourceName: "DropsMacro"), #imageLiteral(resourceName: "ZoomedDrop")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCollectionView()
    }
    
    func initCollectionView() {
        self.collectionView.scrollInterval = 2 //Step 2
        self.collectionViewFlowLayout.scrollDirection = .horizontal
        self.collectionViewFlowLayout.minimumInteritemSpacing = 0
        self.collectionViewFlowLayout.minimumLineSpacing = 0
        self.collectionView.startScrolling() //Step 3
    }
    
    @IBAction func startScrollingButtonTapped(_ sender: Any) {
        self.collectionView.startScrolling()
    }
    
    @IBAction func stopScrollingButtonTapped(_ sender: Any) {
        self.collectionView.stopScrolling() //Step 4
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        self.collectionView.scrollToPreviousOrNextCell(direction: .left) //Step 5
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.collectionView.scrollToPreviousOrNextCell(direction: .right) //Step 6
    }
    
    @IBAction func quitButtonTapped(_ sender: Any) {
        //Don't do this in a real project 🤪
        DispatchQueue.global().async {
            let unwrapMe: Character? = nil
            _ = unwrapMe!
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier: String = "CustomImageCollectionCell"
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomImageCollectionViewCell
        
        cell.imageView.image = self.imagesArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
}

