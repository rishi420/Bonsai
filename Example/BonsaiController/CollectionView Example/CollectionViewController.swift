//
//  CollectionViewController.swift
//  BonsaiController_Example
//
//  Created by Warif Akhand Rishi on 5/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import BonsaiController

class CollectionViewController: UIViewController {

    @IBOutlet weak var aCollectionView: UICollectionView!
    
    let itemCount = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK:- From Storyboard
extension CollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SmallViewController {
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
}

// MARK:- CollectionView Data Source
extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.aLabel.text = "\(indexPath.item)"
        return cell
    }
    
}

// MARK:- CollectionView Delegate (From Code)
//extension CollectionViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
//        vc.view.backgroundColor = .red
//        
//        vc.transitioningDelegate = self
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true, completion: nil)
//    }
//    
//}

// MARK:- BonsaiController Delegate
extension CollectionViewController: BonsaiControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            
        guard let cell = aCollectionView.cellForItem(at: aCollectionView.indexPathsForSelectedItems!.first!) else {
            print("No selected cell")
            return nil
        }
        
        return BonsaiController(fromView: cell, blurEffectStyle: .dark, presentedViewController: presented, delegate: self)
    }
}



