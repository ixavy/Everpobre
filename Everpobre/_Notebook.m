// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Notebook.m instead.

#import "_Notebook.h"

const struct NotebookAttributes NotebookAttributes = {
	.creationDate = @"creationDate",
	.name = @"name",
};

const struct NotebookRelationships NotebookRelationships = {
	.notes = @"notes",
};

const struct NotebookFetchedProperties NotebookFetchedProperties = {
};

@implementation NotebookID
@end

@implementation _Notebook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Notebook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Notebook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Notebook" inManagedObjectContext:moc_];
}

- (NotebookID*)objectID {
	return (NotebookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic creationDate;






@dynamic name;






@dynamic notes;

	
- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];
  
	[self didAccessValueForKey:@"notes"];
	return result;
}
	






@end
