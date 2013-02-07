//
//  IXNoteViewController.h
//  Everpobre
//
//  Created by Javier García Gallego on 27/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import "ATCoreDataTableViewController.h"
@class Notebook;

@interface IXNoteViewController : ATCoreDataTableViewController

-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController notebook:(Notebook *) aNotebook style:(UITableViewStyle)aStyle;

@end
