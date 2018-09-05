//
//  ViewController.swift
//  CustomSizeController
//
//  Created by Warif Akhand Rishi on 22/5/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import UIKit
import CustomSizeController

private enum TransitionType {
    case none
    case slide
    case bubble
    case menu
}

class ViewController: UIViewController {
    
    @IBOutlet weak var popButton: UIButton!
    
    private var transitionType: TransitionType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Code
    @IBAction func ShowSmallVCButtonAction(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.view.backgroundColor = .red
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: nil)
        
        // Dismiss after delay
        // customSizeC?.perform(#selector(customSizeC?.dismiss), with: nil, afterDelay: 5)
        // TODO: NOTIFICAITON
    }
    
    // Popup
    @IBAction func showAsPopupButtonAction(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        CustomSizePopupUtility.shared.show(viewController: vc)
    }
    
    // Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is SmallViewController {
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {}
}

extension ViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        switch transitionType {
        case .none:
            return CGRect(origin: .zero, size: containerViewFrame.size)
        case .slide:
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 2))
        case .bubble:
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
        case .menu:
            return CGRect(origin: .zero, size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        // TODO: TAKE SIZE DELEGATE IN PARAMETER
        var customSizeC = CustomSizeController(fromDirection: .left, presentedViewController: presented)
        
        if transitionType == .bubble {
            customSizeC = CustomSizeController(fromOrigin: popButton.superview!.convert(popButton.frame, to: nil), presentedViewController: presented)
        }
        
        customSizeC.sizeDelegate = self
        return customSizeC
    }
}
