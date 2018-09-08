//
//  CollectionViewController.swift
//  CustomSizeController_Example
//
//  Created by Warif Akhand Rishi on 5/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import CustomSizeController

class CollectionViewController: UIViewController {

    @IBOutlet weak var aCollectionView: UICollectionView!
    
    let itemCount = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

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

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.view.backgroundColor = .red
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
}

extension CollectionViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        if presentedViewController is SlideInMenuViewController {
            return CGRect(origin: .zero, size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
        }
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        // TODO: dismiss button dismisses two view controllera
            
        guard let cell = aCollectionView.cellForItem(at: aCollectionView.indexPathsForSelectedItems!.first!) else {
            print("No selected cell")
            return nil
        }
            
        return CustomSizeController(fromOrigin: cell.superview!.convert(cell.frame, to: nil), presentedViewController: presented, delegate: self)
    }
}



