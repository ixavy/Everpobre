#import "_Note.h"

@interface Note : _Note {}

+(id)noteWithContext:(NSManagedObjectContext *) aContext inNotebook:(Notebook *) aNotebook;

@end
