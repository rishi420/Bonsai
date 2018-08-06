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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        CustomSizePopupUtility.shared.show(viewController: vc)
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
        
        if segue.destination is SmallViewController ||
            segue.destination is SlideInMenuViewController ||
            segue.destination is BubbleViewController {
            
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {}
}

extension ViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        if presentedViewController is SlideInMenuViewController {
            return CGRect(origin: .zero, size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
        }
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        // TODO: TAKE SIZE DELEGATE IN PARAMETER
        var customSizeC = CustomSizeController(fromDirection: .left, presentedViewController: presented)
        
        if presented is BubbleViewController {
            customSizeC = CustomSizeController(fromOrigin: popButton.superview!.convert(popButton.frame, to: nil), presentedViewController: presented)
        }
        
        customSizeC.sizeDelegate = self
        return customSizeC
    }
}
