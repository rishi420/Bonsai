//
//  ObjectiveCViewController.m
//  BonsaiController_Example
//
//  Created by Warif Akhand Rishi on 2/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "ObjectiveCViewController.h"
#import "BonsaiController_Example-Swift.h"

@import BonsaiController;

@interface ObjectiveCViewController () <BonsaiControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *exampleButton;

@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// MARK:- From Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:SmallViewController.class]) {
        segue.destinationViewController.transitioningDelegate = self;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

// MARK:- Or From Code
- (IBAction)exampleButtonAction:(id)sender {
    
//    SmallViewController *smallVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SmallVC"];
//    smallVC.transitioningDelegate = self;
//    smallVC.modalPresentationStyle = UIModalPresentationCustom;
//    [self presentViewController:smallVC animated:true completion:nil];
}


// MARK:- Bonsai Controller Delegate
- (CGRect)frameOfPresentedViewIn:(CGRect)containerViewFrame {
    
    return CGRectMake(0, containerViewFrame.size.height / 4, containerViewFrame.size.width, containerViewFrame.size.height / (4.0 / 3.0));
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    //return [[BonsaiController alloc] initFromDirection:DirectionBottom blurEffectStyle:UIBlurEffectStyleLight presentedViewController:presented delegate:self];
    
    return [[BonsaiController alloc] initFromView:self.exampleButton blurEffectStyle:UIBlurEffectStyleDark presentedViewController:presented delegate:self];
}

@end
