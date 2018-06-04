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
    
    var customSizeC: CustomSizeController?
    
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
        
        customSizeC = CustomSizeController(presentedViewController: vc)
        
        // Disable tap outside
        //customSizeC = CustomSizeController(presentedViewController: vc, isDisabledTapOutside: true)
        
        customSizeC?.sizeDelegate = self
        
        //vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true, completion: nil)
        
        // Dismiss after delay
        //customSizeC?.perform(#selector(customSizeC?.dismiss), with: nil, afterDelay: 5)
    }
    
    // FROM STORYBOARD
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let smallVC = segue.destination as? SmallViewController {
            
            customSizeC = CustomSizeController(presentedViewController: smallVC)
            customSizeC?.sizeDelegate = self
            
            smallVC.view.backgroundColor = .blue
        }
    }
}

extension ViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
}

