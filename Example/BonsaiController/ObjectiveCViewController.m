//
//  ObjectiveCViewController.m
//  BonsaiController_Example
//
//  Created by Warif Akhand Rishi on 2/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "ObjectiveCViewController.h"
#import "BonsaiController-Swift.h"

@interface ObjectiveCViewController () <BonsaiControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *exampleButton;

@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    segue.destinationViewController.transitioningDelegate = self;
    segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
}

#pragma mark- Bonsai Controller Delegate

- (CGRect)frameOfPresentedViewIn:(CGRect)containerViewFrame {
    
    return CGRectMake(0, containerViewFrame.size.height / 4, containerViewFrame.size.width, containerViewFrame.size.height / (4.0 / 3.0));
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    //return [[BonsaiController alloc] initFromDirection: DirectionBottom presentedViewController:presented delegate:self];
    
    return [[BonsaiController alloc] initFromView:self.exampleButton presentedViewController:presented delegate:self];
}

@end
