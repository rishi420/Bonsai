//
//  ViewController.swift
//  BonsaiController
//
//  Created by Warif Akhand Rishi on 22/5/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import UIKit
import BonsaiController
import AVKit // Needed for AVPlayerViewController example

private enum TransitionType {
    case none
    case bubble
    case slide(fromDirection: Direction)
    case menu(fromDirection: Direction)
    case notification(fromDirection: Direction)
}

// TODO: Utility folder Notification utility
// TODO: Create Obj-c example folder
// TODO: Create Obj-c properties
// TODO: Background Color image
// TODO: Blur effect customization
// TODO: origin frame init delete
// TODO: check ! in bonsaicontroller

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
        vc.view.backgroundColor = UIColor(red: 208/255.0, green: 5/255.0, blue: 30/255.0, alpha: 1)
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare Segue")
        
        if segue.destination is SmallViewController {
            transitionType = .slide(fromDirection: .bottom)
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
        showSmallVC(transition: .slide(fromDirection: .top))
    }
    
    @IBAction func bottomButtonAction(_ sender: Any) {
        print("Bottom Button Action")
        showSmallVC(transition: .slide(fromDirection: .bottom))
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
        BonsaiPopupUtility.shared.show(viewController: vc)
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
    
    // MARK: Native Buttons
    @IBAction func imagePickerButtonAction(_ sender: Any) {
        print("Image Picker Button Action")
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Source type not available")
            return
        }
        
        transitionType = .slide(fromDirection: Direction.randomDirection())
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = true
        
        imagePicker.transitioningDelegate = self
        imagePicker.modalPresentationStyle = .custom
        
        self.present(imagePicker, animated: true, completion: nil)
    }
        
    @IBAction func videoPlayerButtonAction(_ sender: Any) {
        print("Video Player Button Action")
        
        transitionType = .slide(fromDirection: Direction.randomDirection())
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        playerViewController.transitioningDelegate = self
        playerViewController.modalPresentationStyle = .custom
        
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

// MARK:- BonsaiController Delegate
extension ViewController: BonsaiControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        switch transitionType {
        case .none:
            return nil
        case .bubble:
            return BonsaiController(fromView: popButton, blurEffectStyle: .dark,  presentedViewController: presented, delegate: self)
        case .slide(let fromDirection), .menu(let fromDirection), .notification(let fromDirection):
            return BonsaiController(fromDirection: fromDirection, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
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
