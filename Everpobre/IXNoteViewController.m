//
//  IXNoteViewController.m
//  Everpobre
//
//  Created by Javier García Gallego on 27/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import "IXNoteViewController.h"
#import "Notebook.h"
#import "Note.h"
#import "IXSingleNoteViewController.h"

@interface IXNoteViewController ()

@property (strong,nonatomic) Notebook *notebook;

@end

@implementation IXNoteViewController

-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController notebook:(Notebook *) aNotebook style:(UITableViewStyle)aStyle{
    
    // Crear el fetchedResultsController
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Note entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    
    request.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", aNotebook];
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:aNotebook.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Lo pasamos a super
    if (self = [super initWithFetchedResultsController:fetched style:UITableViewStylePlain]) {
        self.notebook = aNotebook;
        self.title = aNotebook.name;
    }
    return self;    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Creamos un botón para añadir
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Creamos un botón para editar
    
 //   self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)addButton:(id)sender{
    Note *note = [Note noteWithContext:self.fetchedResultsController.managedObjectContext inNotebook:self.notebook];
    
    NSLog(@"Creada una nueva nota: %@",note);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Data Source

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Identificador
    static NSString *cellId = @"CellId";
    
    // Averiguamos que note nos piden
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Creamos la celda
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        // La creamos de cero
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    // Sincronizamos celda con nota
    cell.textLabel.text = note.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    cell.detailTextLabel.text = [formatter stringFromDate:note.modificationDate];
    
    return cell;
    
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Borramos la nota
        
        // Averiguamos que nota es
        Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Le mandamos el mensaje de deleteObject: al contexto
        [self.fetchedResultsController.managedObjectContext deleteObject:note];
        
        
        // El contexto notificará el cambio y el fetchedResultsController actualizará la tabla
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Muerte !";
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Averiguar la nota sobre la que han tocado
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear un SingleNoteVC
    IXSingleNoteViewController *noteVC = [[IXSingleNoteViewController alloc] initWithNote:note];
    
    // Presentar el SingleNoteVC de forma modal
    noteVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:noteVC animated:YES completion:^{
        //
    }]; 
    
    
}

@end
