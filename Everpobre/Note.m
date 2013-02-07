#import "Note.h"
#import "Notebook.h"


@interface Note ()

// Private interface goes here.

@end


@implementation Note

#pragma mark - Class Methods

// Crear Notas

+(id)noteWithContext:(NSManagedObjectContext *) aContext
          inNotebook:(Notebook *) aNotebook{
    Note *note = [Note insertInManagedObjectContext:aContext];
    
    // Inicializamos propiedades
    
    note.title = @"New note";
    note.creationDate = [NSDate date];
    
    // Asignamos libreta
    
    note.notebook = aNotebook;
    [aNotebook addNotesObject:note];
    
    return note;
}

#pragma mark - Init & dealloc

-(void)awakeFromInsert{
    // Me lo envían despues de mi creacion
    [super awakeFromInsert];
    
    // Alta como observador de mis propias propiedades
    for (NSString *each in @[@"title",@"text",@"photo"]){
        [self addObserver:self
               forKeyPath:each
                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
}

-(void)awakeFromFetch{
    // Lo envían después de recuperarme de la base de datos
    [super awakeFromFetch];
    
    // Alta como observador de mis propias propiedades
    for (NSString *each in @[@"title",@"text",@"photo"]){
        [self addObserver:self
               forKeyPath:each
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }

}

-(void)willTurnIntoFault{
    // Me lo envían justo antes de palmar
    
    [super willTurnIntoFault];
    
    // Me doy de baja de todas las notificaciones
    
    for (NSString *each in @[@"title",@"text",@"photo"]){
        [self removeObserver:self
                  forKeyPath:each];
    }
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    self.modificationDate = [NSDate date];
}

@end
