//
//  IXSingleNoteViewController.h
//  Everpobre
//
//  Created by Javier García Gallego on 27/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@interface IXSingleNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)hideView:(id)sender;

-(id)initWithNote:(Note *) aNote;

@end
