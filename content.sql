CREATE SCHEMA public;

CREATE TABLE "contentPriorityCode" ( 
	"priorityID"         integer  NOT NULL,
	"priorityDescription" text  ,
	CONSTRAINT "contentPriorityCode_pkey" PRIMARY KEY ( "priorityID" )
 );

CREATE TABLE "contentResourceType" ( 
	"contentResourceTypeID" integer  NOT NULL,
	"contentResourceTypeDescription" text  ,
	CONSTRAINT "contentResourceType_pkey" PRIMARY KEY ( "contentResourceTypeID" )
 );

CREATE TABLE "pieChart" ( 
	"imodID"             integer  NOT NULL,
	count                integer  ,
	priority             integer  NOT NULL,
	CONSTRAINT "pieChart_priority_fkey" FOREIGN KEY ( priority ) REFERENCES "contentPriorityCode"( "priorityID" )    ,
	CONSTRAINT "pieChart_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES imod( "imodID" )    
 );

CREATE TABLE "schedule" ( 
	"imodID"             integer  NOT NULL,
	repeats              varchar( 255 )  ,
	"repeatsEvery"       varchar( 10 )  ,
	"repeatsDays"        varchar( 15 )  ,
	"startDate"          varchar( 15 )  ,
	"endDate"            varchar( 15 )  ,
	"endOccurrences"     integer  ,
	monday               integer  ,
	tuesday              integer  ,
	wednesday            integer  ,
	thursday             integer  ,
	friday               integer  ,
	saturday             integer  ,
	sunday               integer  ,
	CONSTRAINT "schedule_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES imod( "imodID" )    
 );

CREATE TABLE "scheduleDate" ( 
	"imodID"             integer  NOT NULL,
	date                 varchar( 255 )  ,
	CONSTRAINT "scheduleDates_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES imod( "imodID" )    
 );

CREATE INDEX fki_imodID ON "scheduleDate" ( "imodID" );

CREATE TABLE "content" ( 
	"contentID"          integer  NOT NULL,
	"learningObjectiveID" integer  NOT NULL,
	"topicTitle"         varchar( 255 )  ,
	"priorityID"         integer  NOT NULL,
	CONSTRAINT "Content_pkey" PRIMARY KEY ( "contentID" ),
	CONSTRAINT "content_priorityID_fkey" FOREIGN KEY ( "priorityID" ) REFERENCES "contentPriorityCode"( "priorityID" )    ,
	CONSTRAINT "content_learningObjectiveID_fkey" FOREIGN KEY ( "learningObjectiveID" ) REFERENCES "learningObjective"( "learningObjectiveID" )    
 );

CREATE INDEX fki_LearningObjectiveID ON content ( "learningObjectiveID" );

CREATE TABLE "contentHeirarchy" ( 
	"hierarchyID"        integer  NOT NULL,
	"parentContentID"    integer  NOT NULL,
	"leafContentID"      integer  NOT NULL,
	CONSTRAINT "ContentHeirarchy_pkey" PRIMARY KEY ( "hierarchyID" ),
	CONSTRAINT "leafContentID" FOREIGN KEY ( "leafContentID" ) REFERENCES content( "contentID" )    ,
	CONSTRAINT "parentContentID" FOREIGN KEY ( "parentContentID" ) REFERENCES content( "contentID" )    
 );

CREATE INDEX fki_leafContentID ON "contentHeirarchy" ( "leafContentID" );

CREATE INDEX fki_parentContentID ON "contentHeirarchy" ( "parentContentID" );

CREATE TABLE "contentResource" ( 
	"contentResourceID"  integer  NOT NULL,
	"contentID"          integer  NOT NULL,
	"contentResourceTitle" varchar( 255 )  ,
	"contentResourceType" integer  NOT NULL,
	CONSTRAINT "Resource_pkey" PRIMARY KEY ( "contentResourceID" ),
	CONSTRAINT "contentResource_contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES content( "contentID" )    ,
	CONSTRAINT "contentResource_contentResourceType_fkey" FOREIGN KEY ( "contentResourceType" ) REFERENCES "contentResourceType"( "contentResourceTypeID" )    
 );

CREATE INDEX Resource_ContentID_idx ON "contentResource" ( "contentID" );

