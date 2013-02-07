//
//  IXNotebookViewController.m
//  Everpobre
//
//  Created by Javier García Gallego on 27/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import "IXNotebookViewController.h"
#import "Notebook.h"
#import "IXNoteViewController.h"

@interface IXNotebookViewController ()

@end

@implementation IXNotebookViewController

-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                style:(UITableViewStyle)aStyle {
    if (self = [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]) {
        self.title = @"Everpobre";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Creamos un botón para añadir
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Creamos un botón para editar
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)addButton:(id)sender{
    NSManagedObjectContext *ctxt = self.fetchedResultsController.managedObjectContext;
    
    Notebook *nb = [Notebook notebookWithContext:ctxt];
    
    NSLog(@"Creado un nuevo notebook: %@",nb);
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
    
    // Averiguamos que notebook nos piden
    
    Notebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Creamos la celda
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        // La creamos de cero
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Sincronizamos celda con notebook
    cell.textLabel.text = nb.name;
    
    return cell;
    
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Borramos el notebook
        
        // Averiguamos que notebook es
        Notebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Le mandamos el mensaje de deleteObject: al contexto
        [self.fetchedResultsController.managedObjectContext deleteObject:nb];
        
        
        // El contexto notificará el cambio y el fetchedResultsController actualizará la tabla
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Muerte !";
}

#pragma mark - Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Averiguar qué notebook es
    
    Notebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear un controlador
    
    IXNoteViewController *noteVC = [[IXNoteViewController alloc] initWithFetchedResultsController:self.fetchedResultsController notebook:nb style:UITableViewStylePlain];
    
    // Hacer un push
    [self.navigationController pushViewController:noteVC animated:YES];
    
}

@end
