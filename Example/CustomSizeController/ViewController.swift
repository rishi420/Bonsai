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
    case bubble
    case slide(fromDirection: Direction)
    case menu(fromDirection: Direction)
}

// TODO:- Test with build in view controlers mailVC, SMSVC, VideoPlayerVC

class ViewController: UIViewController {
    
    @IBOutlet weak var popButton: UIButton!
    
    private var transitionType: TransitionType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Code
    @IBAction func ShowSmallVCButtonAction(_ sender: Any) {

        transitionType = .slide(fromDirection: .right)
        
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
            transitionType = .slide(fromDirection: .down)
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {}
}

extension ViewController: CustomSizeControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        switch transitionType {
        case .none:
            return nil
        case .bubble:
            return CustomSizeController(fromOrigin: popButton.superview!.convert(popButton.frame, to: nil), presentedViewController: presented, delegate: self)
        case .slide(let fromDirection), .menu(let fromDirection):
            return CustomSizeController(fromDirection: fromDirection, presentedViewController: presented, delegate: self)
        }
    }
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        switch transitionType {
        case .none:
            return CGRect(origin: .zero, size: containerViewFrame.size)
        case .slide:
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
        case .bubble:
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 2))
        case .menu:
            return CGRect(origin: .zero, size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
        }
    }
}
