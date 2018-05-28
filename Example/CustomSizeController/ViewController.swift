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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func ShowSmallVCButtonAction(_ sender: Any) {
        
        //let vc = UIViewController()
        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.view.backgroundColor = .red
        
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let smallVC = segue.destination as? SmallViewController {
            
            smallVC.modalPresentationStyle = .custom
            smallVC.view.backgroundColor = .blue
            smallVC.transitioningDelegate = self
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let customSizePC = CustomSizeController(presentedViewController: presented, presenting: presenting)
        customSizePC.sizeDelegate = self
        //customSizePC.isDisabledTapOutside = true
        
        return customSizePC
    }
}

extension ViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
}

