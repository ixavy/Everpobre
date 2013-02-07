//
//  IXSingleNoteViewController.m
//  Everpobre
//
//  Created by Javier García Gallego on 27/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import "IXSingleNoteViewController.h"
#import "Note.h"

@interface IXSingleNoteViewController ()

@property (strong, nonatomic) Note *model;

@end

@implementation IXSingleNoteViewController

-(id)initWithNote:(Note *) aNote{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aNote;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Sincronizamos la vista con el modelo (la nota)
    self.titleView.text = self.model.title;
    self.textView.text = self.model.text;
    
    // Le damos un borde redondeado a la textView
    
    self.textView.layer.borderWidth = 2.0;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.cornerRadius = 10.0;
    self.textView.clipsToBounds = YES;
    
    // Alta en la notificación de teclado
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillAppear:(NSNotification *) note {
    NSLog(@"Allá va");
    NSDictionary *info = note.userInfo;
    
    float duration = [[info objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect newFrame = self.textView.frame;
        newFrame.size.height = newFrame.size.height - 216 + 5; // este valor lo debería coger del teclado
        self.textView.frame = newFrame;
    }];
    
}

-(void)keyboardWillDisappear:(NSNotification *)note {
    NSLog(@"Adiós teclado");
    NSDictionary *info = note.userInfo;
    
    float duration = [[info objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect newFrame = self.textView.frame;
        newFrame.size.height = newFrame.size.height + 216 - 5; // este valor lo debería coger del teclado
        self.textView.frame = newFrame;
    }];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Guardar en el modelo lo que esté en la vista
    
    self.model.title = self.titleView.text;
    self.model.text = self.textView.text;
    
    // Baja en la notificación de teclado
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender {
    
    // Sea quien sea que tenga el foco (firstResponder) que lo suelte ya
    
    [self.view endEditing:YES];
}

- (IBAction)hideView:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

@end
