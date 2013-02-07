#import "Notebook.h"


@interface Notebook ()

// Private interface goes here.

@end


@implementation Notebook


// Crear Notebooks

+(id)notebookWithContext:(NSManagedObjectContext *)aContext{
    
    Notebook *nb = [Notebook insertInManagedObjectContext:aContext];
    
    // Inicializamos propiedades
    nb.creationDate = [NSDate date];
    
    return nb;
}

@end
