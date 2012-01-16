//
//  ApplicationDatabase.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

/**
	This class is for accessing the SQL Lite database and storing information into and retrieving information from the database.

 */
@interface ApplicationDatabase : NSObject
{
    sqlite3 *database_pointer;
    char *error_message;
}
+ (ApplicationDatabase *)sharedInstance;

//Creating a table
-(void)createUserInformationTable;
-(void)createUsersFacebookFriendsTable;

-(BOOL)hasUserInformationTableBeenPopulated;
-(void)closeDatabase;


//UserInformation methods.
-(void)insertOrUpdateUserInformationWithDictionary:(NSDictionary*)the_values;
-(NSMutableDictionary*)getUserInformationFromDatabase;

//FacebookMethods
-(void)insertFacebookFriend:(NSDictionary*)the_values;
-(NSMutableArray*)getFacebookFriendFromDatabase;
-(void)dropfacebookFriendsTable;


//Table Deletes
-(void)dropAllTables;
@end

/**UserInformation Table Creation SQL METHOD
 CREATE TABLE user_information (
 0-name VARCHAR, 
 1-facebook_friend_count VARCHAR, 
 2-session_key VARCHAR,
 3-facebook_uid VARCHAR,
 4-avatar VARCHAR, 
 5-gender VARCHAR,
 6-user_id INTEGER,
 7-avatar_thumb VARCHAR,
 8-facebook_session_key VARCHAR, 
 9-birthday VARCHAR, 
 10-last_name VARCHAR, 
 11-locale VARCHAR, 
 12-first_name VARCHAR, 
 13-email VARCHAR)
*/