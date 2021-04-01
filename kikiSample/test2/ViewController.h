//
//  ViewController.h
//  test2
//
//  Created by ksfc on 2020/09/24.
//  Copyright © 2020 ksfc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *edit;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *btWebView;
@property (weak, nonatomic) IBOutlet UIButton *buttonFile;
@property (weak, nonatomic) IBOutlet UIButton *btnMsg;

- (IBAction)click:(id)sender;

@end

