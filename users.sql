CREATE SCHEMA public;

CREATE TABLE "userRole" ( 
	"userRoleID"         integer  NOT NULL,
	"userRoleDescription" varchar( 255 )  ,
	CONSTRAINT "userRole_pkey" PRIMARY KEY ( "userRoleID" )
 );

CREATE TABLE user ( 
	"userID"             integer  NOT NULL,
	"userName"           varchar( 255 )  NOT NULL,
	password             varchar( 255 )  NOT NULL,
	"emailID"            varchar( 255 )  ,
	"fullName"           varchar( 255 )  ,
	"userRoleID"         integer  NOT NULL,
	CONSTRAINT "User_pkey" PRIMARY KEY ( "userID" ),
	CONSTRAINT "User_UserName_key" UNIQUE ( "userName" ) ,
	CONSTRAINT "userRoleID" FOREIGN KEY ( "userRoleID" ) REFERENCES "userRole"( "userRoleID" )    
 );

CREATE INDEX fki_userRoleID ON user ( "userRoleID" );

CREATE TABLE "userProfile" ( 
	"userID"             integer  NOT NULL,
	organization         varchar( 255 )  ,
	"themeCode"          varchar( 255 )  ,
	"fullName"           varchar( 255 )  ,
	"streetAddress"      varchar( 255 )  ,
	city                 varchar( 255 )  ,
	state                varchar( 255 )  ,
	country              varchar( 255 )  ,
	zip                  varchar( 50 )  ,
	CONSTRAINT "userID" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
 );

CREATE INDEX fki_userID ON "userProfile" ( "userID" );

