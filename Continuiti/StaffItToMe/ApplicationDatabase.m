//
//  ApplicationDatabase.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationDatabase.h"
static char *database_name = "TWDatabase.db";
static ApplicationDatabase *shared = NULL;
@implementation ApplicationDatabase
/**
	Default initializer for this ApplicationDatabse object. It gets the database and sets up queries.
	@returns ApplicationDatabase
 */
-(id)init
{
    if ((self = [super init]))
    {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:[NSString stringWithCString:database_name encoding:NSStringEncodingConversionAllowLossy]];
        if (sqlite3_open([databasePath UTF8String], &database_pointer) != SQLITE_OK)
        {
            fprintf(stderr, "Error could not open database. Error: %s", sqlite3_errmsg(database_pointer));
            sqlite3_close(database_pointer);
            return nil;
        }
    }
    return self;
}
-(void)closeDatabase
{
    sqlite3_close(database_pointer);
}
-(void)dropAllTables
{
    char *drop_users_information = "DROP TABLE user_information";
    if (sqlite3_exec(database_pointer, drop_users_information, NULL, NULL, &error_message) != SQLITE_OK)
    {
        fprintf(stderr, "Error dropping user_information table. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
    
    char *drop_users_facebook_friends_table = "DROP TABLE users_facebook_friends";
    if (sqlite3_exec(database_pointer, drop_users_facebook_friends_table, NULL, NULL, &error_message) != SQLITE_OK)
    {
        fprintf(stderr, "Error dropping users_facebook_friends table. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
}
-(void)dropfacebookFriendsTable
{
    char *drop_users_facebook_friends_table = "DROP TABLE users_facebook_friends";
    sqlite3_exec(database_pointer, drop_users_facebook_friends_table, NULL, NULL, &error_message);
}
-(BOOL)hasUserInformationTableBeenPopulated
{
    sqlite3_stmt *table_check_statement;
    char *user_table_check = "SELECT * FROM user_information";
    
    if (sqlite3_prepare_v2(database_pointer, user_table_check, strlen(user_table_check), &table_check_statement, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error in getting user_information tables existence. Error :%s", sqlite3_errmsg(database_pointer));
        sqlite3_close(database_pointer);
        return;
    }
    sqlite3_step(table_check_statement);
    
    const char *user_information_table_name = (const char*)sqlite3_column_text(table_check_statement, 0);
    
    if (user_information_table_name != nil)
    {
        sqlite3_finalize(table_check_statement);
        return YES;
    }
    else
    {
        sqlite3_finalize(table_check_statement);
        return NO;
    }
}
/**
	Sets up the user information database for insertions later.
 */
-(void)createUserInformationTable
{
    sqlite3_stmt *table_check_statement;
    char *user_table_check = "SELECT name FROM sqlite_master WHERE type='table' AND name='user_information';";
    if (sqlite3_prepare_v2(database_pointer, user_table_check, strlen(user_table_check), &table_check_statement, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error in getting user_information tables existence. Error :%s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
        return;
    }
    sqlite3_step(table_check_statement);
    
    const char *user_information_table_name;
    user_information_table_name = (const char*)sqlite3_column_text(table_check_statement, 0);
    
    if (user_information_table_name != nil)
    {
    }
    else
    {
        char *create_user_information_table = "CREATE TABLE user_information (name VARCHAR, facebook_friend_count VARCHAR, session_key VARCHAR, facebook_uid VARCHAR, avatar VARCHAR, gender VARCHAR, user_id VARCHAR, avatar_thumb VARCHAR, facebook_session_key VARCHAR, last_name VARCHAR, locale VARCHAR, first_name VARCHAR, email VARCHAR)";
        if (sqlite3_exec(database_pointer, create_user_information_table, NULL, NULL, &error_message) != SQLITE_OK)
        {
            fprintf(stderr, "Error in creating user information table. Error: %s", sqlite3_errmsg(database_pointer));
            sqlite3_free(error_message);
        }
    }
    sqlite3_finalize(table_check_statement);
}

/**
	Sets up the users location table in the database.
 */
-(void)createUserLocationInformationTable
{
    sqlite3_stmt *table_check_statement;
    char *user_table_check = "SELECT name FROM sqlite_master WHERE type='table' AND name='user_location';";
    if (sqlite3_prepare_v2(database_pointer, user_table_check, strlen(user_table_check), &table_check_statement, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error in retrieving users location information. Error :%s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
        return;
    }
    sqlite3_step(table_check_statement);
    
    const char *user_location_table_name;
    user_location_table_name = (const char*)sqlite3_column_text(table_check_statement, 0);
    if (user_location_table_name != nil)
    {
    }
    else
    {
        char *create_user_location_table = "CREATE TABLE user_location (latitude VARCHAR, longitude VARCHAR)";
        if (sqlite3_exec(database_pointer, create_user_location_table, NULL, NULL, &error_message) != SQLITE_OK)
        {
            fprintf(stderr, "Error in creating user location table. Error: %s", sqlite3_errmsg(database_pointer));
            sqlite3_free(error_message);
        }
    }
    sqlite3_finalize(table_check_statement);
}
/**
    Sets up the users_facebook_friends table for insertions later.
 */
-(void)createUsersFacebookFriendsTable
{
    sqlite3_stmt *facebook_friend_table_check;
    char *facebook_friend_table_check_string = "SELECT name FROM sqlite_master WHERE type='table' AND name='users_facebook_friends';";
    if (sqlite3_prepare(database_pointer, facebook_friend_table_check_string, strlen(facebook_friend_table_check_string), &facebook_friend_table_check, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error in getting users_facebook_friends table's existence. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
        sqlite3_close(database_pointer);
    }
    sqlite3_step(facebook_friend_table_check);
    
    const char *users_facebook_friends_table_name = (const char*) sqlite3_column_text(facebook_friend_table_check, 0);
    
    if (users_facebook_friends_table_name != nil)
    {
    }
    else
    {
        char *create_users_facebook_friends_table = "CREATE TABLE users_facebook_friends (name VARCHAR, facebook_id VARCHAR)";
        if (sqlite3_exec(database_pointer, create_users_facebook_friends_table, NULL, NULL, &error_message) != SQLITE_OK)
        {
            fprintf(stderr, "Error in creating users_facebook_friends table. Error: %s", sqlite3_errmsg(database_pointer));
            sqlite3_free(error_message);
            sqlite3_close(database_pointer);
        }
    }
    sqlite3_finalize(facebook_friend_table_check);
}
-(void)insertFacebookFriend:(NSDictionary*)the_values
{
    NSString *insert_friend_into_nsstring = [NSString stringWithFormat:@"INSERT INTO users_facebook_friends VALUES ('%@', '%@')", [the_values objectForKey:@"friend_name"], [the_values objectForKey:@"friend_id"]];
    
    const char *insert_friend_into_table = [insert_friend_into_nsstring UTF8String];
    if (sqlite3_exec(database_pointer, insert_friend_into_table, NULL, NULL, &error_message) != SQLITE_OK)
    {
        fprintf(stderr, "Error inserting facebook friend int users_facebook_friends. Error %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
}
-(void)insertUserInformationIntoUserInformationTableWithDictionary:(NSDictionary*)the_values
{
    NSString *inser_user_into_nsstring = [NSString stringWithFormat:@"INSERT INTO user_information VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", 
                                          [the_values objectForKey:@"name"],
                                          [the_values objectForKey:@"facebook_friend_count"],
                                          [the_values objectForKey:@"session_key"],
                                          [the_values objectForKey:@"facebook_uid"],
                                          [the_values objectForKey:@"avatar"],
                                          [the_values objectForKey:@"gender"],
                                          [the_values objectForKey:@"user_id"],
                                          [the_values objectForKey:@"avatar_thumb"],
                                          [the_values objectForKey:@"facebook_session_key"],
                                          [the_values objectForKey:@"last_name"],
                                          [the_values objectForKey:@"local"],
                                          [the_values objectForKey:@"first_name"],
                                          [the_values objectForKey:@"email"]];
    
   const char *insert_user_into_table = [inser_user_into_nsstring UTF8String];
    if (sqlite3_exec(database_pointer, insert_user_into_table, NULL, NULL, &error_message) != SQLITE_OK) {
        fprintf(stderr, "Error in inserting user information into user_information table. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
}
-(void)updateUserInformationIntoUserInformationTableWithDictionary:(NSDictionary*)the_values
{
    NSString *inser_user_into_nsstring = [NSString stringWithFormat:@"UPDATE user_information SET name = '%@', facebook_friend_count = '%@', session_key = '%@', facebook_uid = '%@', avatar = '%@', gender = '%@', user_id = '%@', avatar_thumb = '%@', facebook_session_key = '%@', last_name = '%@', locale = '%@', first_name = '%@', email = '%@'", 
                                          [the_values objectForKey:@"name"],
                                          [the_values objectForKey:@"facebook_friend_count"],
                                          [the_values objectForKey:@"session_key"],
                                          [the_values objectForKey:@"facebook_uid"],
                                          [the_values objectForKey:@"avatar"],
                                          [the_values objectForKey:@"gender"],
                                          [the_values objectForKey:@"user_id"],
                                          [the_values objectForKey:@"avatar_thumb"],
                                          [the_values objectForKey:@"facebook_session_key"],
                                          [the_values objectForKey:@"last_name"],
                                          [the_values objectForKey:@"local"],
                                          [the_values objectForKey:@"first_name"],
                                          [the_values objectForKey:@"email"]];
    
    const char *insert_user_into_table = [inser_user_into_nsstring UTF8String];
    if (sqlite3_exec(database_pointer, insert_user_into_table, NULL, NULL, &error_message) != SQLITE_OK) {
        fprintf(stderr, "Error in updating user information into user_information table. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
}
-(void)insertIntoLocationTableUserLocationWithDictionary:(NSDictionary*)the_values
{
    NSString *insert_user_location_string = [NSString stringWithFormat:@"INSERT INTO user_location VALUES ('%@', '%@')", [the_values objectForKey:@"latitude"], [the_values objectForKey:@"longitude"]];
    
    const char *insert_location = [insert_user_location_string UTF8String];
    if (sqlite3_exec(database_pointer, insert_location, NULL, NULL, &error_message) != SQLITE_OK) {
        
        fprintf(stderr, "Error in inserting user information into user_location table. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
}
-(void)updateUserLocationIntoLocationTableWithDictionary:(NSDictionary*)the_values {
     
    NSString *update_user_location_string = [NSString stringWithFormat:@"UPDATE user_location SET latitude = '%@', longitude = '%@'", [the_values objectForKey:@"latitude"], [the_values objectForKey:@"longitude"]]; 
    
    const char *update_location = [update_user_location_string UTF8String];
    if (sqlite3_exec(database_pointer, update_location, NULL, NULL, &error_message) != SQLITE_OK) {
        
        fprintf(stderr, "Error in inserting user information into user_location table. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
}
-(void)insertOrUpdateUserInformationWithDictionary:(NSDictionary*)the_values
{
    sqlite3_stmt *check_user_exists;
    char *user_exists_string = "SELECT * FROM user_information;";
    if (sqlite3_prepare(database_pointer, user_exists_string, strlen(user_exists_string), &check_user_exists, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error while checking if user existed in the user information table already. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
        return;
    }
    sqlite3_step(check_user_exists);
    
    const char *user_information_username = (const char*)sqlite3_column_text(check_user_exists, 0);
    if (user_information_username != nil) {
        sqlite3_finalize(check_user_exists);
        [self updateUserInformationIntoUserInformationTableWithDictionary:the_values];
    }
    else
    {
        sqlite3_finalize(check_user_exists);
        [self insertUserInformationIntoUserInformationTableWithDictionary:the_values];
    }
}
-(void)insertOrUpdateUserLocationInformationWithDictionary:(NSDictionary*)the_values
{
    sqlite3_stmt *check_location_exists;
    char *location_exists_string = "SELECT * FROM user_location;";
    if (sqlite3_prepare(database_pointer, location_exists_string, strlen(location_exists_string), &check_location_exists, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error while checking if location was set. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
        return;
    }
    sqlite3_step(check_location_exists);
    
    const char *location_information = (const char*)sqlite3_column_text(check_location_exists, 0);
    if (location_information != nil)
    {
        sqlite3_finalize(check_location_exists);
        [self updateUserLocationIntoLocationTableWithDictionary:the_values];
    }
    else
    {
        sqlite3_finalize(check_location_exists);
        [self insertIntoLocationTableUserLocationWithDictionary:the_values];
    }
}
-(NSMutableArray*)getFacebookFriendFromDatabase
{
    NSMutableArray *facebook_friends = [[NSMutableArray alloc] initWithCapacity:100];
    sqlite3_stmt *get_facebook_friends_stmt;
    
    char *facebook_friends_request = "SELECT * FROM users_facebook_friends";
    if (sqlite3_prepare(database_pointer, facebook_friends_request, strlen(facebook_friends_request), &get_facebook_friends_stmt, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error while preparing to retrieve facebook friends. Error %s", sqlite3_errmsg(error_message));
        sqlite3_free(error_message);
    }
    
    while (sqlite3_step(get_facebook_friends_stmt) == SQLITE_ROW)
    {
        NSMutableDictionary *friend_info = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        const char *name        = (const char*)sqlite3_column_text(get_facebook_friends_stmt, 0);
        const char *friend_id   = (const char*)sqlite3_column_text(get_facebook_friends_stmt, 1);
        
        [friend_info setObject:[NSString stringWithFormat:@"%s", name] forKey:@"friend_name"];
        [friend_info setObject:[NSString stringWithFormat:@"%s", friend_id] forKey:@"friend_id"];
        
        [facebook_friends addObject:friend_info];
    }
    sqlite3_finalize(get_facebook_friends_stmt);
    return facebook_friends;
}
-(NSMutableDictionary*)getUserInformationFromDatabase
{
    sqlite3_stmt *get_user_information;
    char *user_information_request = "SELECT * FROM user_information;";
    if (sqlite3_prepare(database_pointer, user_information_request, strlen(user_information_request), &get_user_information, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error while preparing to retrieve user information. Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
    sqlite3_step(get_user_information);
    
    const char *name                    = (const char*)sqlite3_column_text(get_user_information, 0);
    const char *facebook_friend_count   = (const char*)sqlite3_column_text(get_user_information, 1);
    const char *session_key             = (const char*)sqlite3_column_text(get_user_information, 2);
    const char *facebook_uid            = (const char*)sqlite3_column_text(get_user_information, 3);
    const char *avatar                  = (const char*)sqlite3_column_text(get_user_information, 4);
    const char *gender                  = (const char*)sqlite3_column_text(get_user_information, 5);
    const char *user_id                 = (const char*)sqlite3_column_text(get_user_information, 6);
    const char *avatar_thumb            = (const char*)sqlite3_column_text(get_user_information, 7);
    const char *facebook_session_key    = (const char*)sqlite3_column_text(get_user_information, 8);
    const char *last_name               = (const char*)sqlite3_column_text(get_user_information, 9);
    const char *locale                  = (const char*)sqlite3_column_text(get_user_information, 10);
    const char *first_name              = (const char*)sqlite3_column_text(get_user_information, 11);
    const char *email                   = (const char*)sqlite3_column_text(get_user_information, 12);
    
    NSMutableDictionary *user_information_dictionary = [[NSMutableDictionary alloc] initWithCapacity:14];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", name] forKey:@"name"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", facebook_friend_count] forKey:@"facebook_friend_count"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", session_key] forKey:@"session_key"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", facebook_uid] forKey:@"facebook_uid"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", avatar] forKey:@"avatar"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", gender]forKey:@"gender"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", user_id] forKey:@"user_id"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", avatar_thumb] forKey:@"avatar_thumb"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", facebook_session_key] forKey:@"facebook_session_key"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", last_name] forKey:@"last_name"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", locale] forKey:@"locale"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", first_name] forKey:@"first_name"];
    [user_information_dictionary setObject:[NSString stringWithFormat:@"%s", email] forKey:@"email"];
    
    sqlite3_finalize(get_user_information);
    return user_information_dictionary;
}
-(NSMutableDictionary*)getUserLocationInformationFromDatabase
{
    sqlite3_stmt *get_user_location;
    char *user_location_request = "SELECT * FROM user_location;";
    if (sqlite3_prepare(database_pointer, user_location_request, strlen(user_location_request), &get_user_location, NULL) != SQLITE_OK)
    {
        fprintf(stderr, "Error while retrieving user location information: Error: %s", sqlite3_errmsg(database_pointer));
        sqlite3_free(error_message);
    }
    sqlite3_step(get_user_location);
    
    const char *latitude    = (const char*)sqlite3_column_text(get_user_location, 0);
    const char *longitude   = (const char*)sqlite3_column_text(get_user_location, 1);
    
    NSMutableDictionary *user_location_dictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [user_location_dictionary setObject:[NSString stringWithFormat:@"%s", latitude] forKey:@"latitude"];
    [user_location_dictionary setObject:[NSString stringWithFormat:@"%s", longitude] forKey:@"longitude"];
     
     sqlite3_finalize(get_user_location);
     return user_location_dictionary;
}
#pragma mark singleton_items
/**
	Gets the global ApplicationDatabase class.
 
	@returns ApplicationDatabase.
 */
+ (ApplicationDatabase*) sharedInstance

{	
	// allocate the shared instance, because it hasn't been done yet
	@synchronized( shared ) {
		if ( !shared || shared == NULL ) {
			shared = [[ApplicationDatabase alloc] init];
		}
	}
	return shared;
}
@end
