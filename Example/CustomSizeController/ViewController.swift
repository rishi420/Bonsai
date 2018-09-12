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
    case notification(fromDirection: Direction)
}

// TODO: Test with build in view controlers mailVC, SMSVC, VideoPlayerVC
// TODO: Rename PopTransition to BubbleTransition

class ViewController: UIViewController {
    
    @IBOutlet weak var popButton: UIButton!
    
    private var transitionType: TransitionType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Show Small View controller
    private func showSmallVC(transition: TransitionType) {
        
        transitionType = transition
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.view.backgroundColor = .red
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare Segue")
        
        if segue.destination is SmallViewController {
            transitionType = .slide(fromDirection: .down)
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
}

// MARK:- Button Actions
extension ViewController {
    
    // MARK: Slide in Buttons
    @IBAction func leftButtonAction(_ sender: Any) {
        print("Left Button Action")
        showSmallVC(transition: .slide(fromDirection: .left))
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        print("Right Button Action")
        showSmallVC(transition: .slide(fromDirection: .right))
    }
    
    @IBAction func topButtonAction(_ sender: Any) {
        print("Top Button Action")
        showSmallVC(transition: .slide(fromDirection: .up))
    }
    
    @IBAction func bottomButtonAction(_ sender: Any) {
        print("Bottom Button Action")
        showSmallVC(transition: .slide(fromDirection: .down))
    }
    
    // MARK: Menu Buttons
    @IBAction func leftMenuButtonAction(_ sender: Any) {
        print("Left Menu Button Action")
        showSmallVC(transition: .menu(fromDirection: .left))
    }
    
    @IBAction func rightMenuButtonAction(_ sender: Any) {
        print("Right Menu Button Action")
        showSmallVC(transition: .menu(fromDirection: .right))
    }
    
    // MARK: Popup Button
    @IBAction func showAsPopupButtonAction(_ sender: Any) {
        print("Popup Button Action")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        CustomSizePopupUtility.shared.show(viewController: vc)
    }
    
    // MARK: Notification Button
    @IBAction func notificationButtonAction(_ sender: Any) {
        print("Notification Button Action")
        
        transitionType = .notification(fromDirection: .right)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
    
        vc.perform(#selector(vc.dismissButtonAction(_:)), with: nil, afterDelay: 2)
        
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Bubble Button
    @IBAction func bubbleButtonAction(_ sender: Any) {
        print("Bubble Button Action")
        showSmallVC(transition: .bubble)
    }
}

// MARK:- CustomSizeController Delegate
extension ViewController: CustomSizeControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        switch transitionType {
        case .none:
            return nil
        case .bubble:
            return CustomSizeController(fromView: popButton, presentedViewController: presented, delegate: self)
        case .slide(let fromDirection), .menu(let fromDirection), .notification(let fromDirection):
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
        case .menu(let fromDirection):
            var origin = CGPoint.zero
            if fromDirection == .right {
                origin = CGPoint(x: containerViewFrame.width / 2, y: 0)
            }
            return CGRect(origin: origin, size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
        case .notification:
            let origin = CGPoint.zero
            return CGRect(origin: origin, size: CGSize(width: containerViewFrame.width, height: 120))
        }
    }
}
