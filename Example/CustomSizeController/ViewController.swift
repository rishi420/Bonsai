//
//  ViewController.swift
//  CustomSizeController
//
//  Created by Warif Akhand Rishi on 22/5/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import UIKit
import CustomSizeController

class ViewController: UIViewController {
    
    @IBOutlet weak var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Popup
    @IBAction func showAsPopupButtonAction(_ sender: Any) {
        CustomSizePopupUtility.shared.show()
    }
    
    // FROM CODE
    @IBAction func ShowSmallVCButtonAction(_ sender: Any) {
        
        //let vc = UIViewController() // Any ViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.view.backgroundColor = .red
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        
        // Disable tap outside
        //customSizeC = CustomSizeController(presentedViewController: vc, isDisabledTapOutside: true)
        
        //vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true, completion: nil)
        
        // Dismiss after delay
        //customSizeC?.perform(#selector(customSizeC?.dismiss), with: nil, afterDelay: 5)
    }
    
    // FROM STORYBOARD
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let smallVC = segue.destination as? SmallViewController {
            
            smallVC.view.backgroundColor = .blue
            
            smallVC.transitioningDelegate = self
            smallVC.modalPresentationStyle = .custom
        }
    }
}

extension ViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let customSizeC = CustomSizeController(presentedViewController: presented, fromOrigin: popButton.superview!.convert(popButton.frame, to: nil))
        customSizeC.sizeDelegate = self
        return customSizeC
    }
}

/// Transition animation delegates
//extension ViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

//    }

//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

//    }
//}
