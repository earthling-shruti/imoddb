CREATE SCHEMA public;

CREATE TABLE audience ( 
	"audienceID"         integer  NOT NULL,
	"audienceDescription" text  ,
	CONSTRAINT "Audience_pkey" PRIMARY KEY ( "audienceID" )
 );

CREATE TABLE "componentDesignation" ( 
	"designationID"      integer  NOT NULL,
	"designationDescription" varchar( 255 )  ,
	CONSTRAINT "ComponentDesignation_pkey" PRIMARY KEY ( "designationID" )
 );

CREATE TABLE "courseComponentCode" ( 
	"courseComponentID"  integer  NOT NULL,
	"courseComponentDescription" text  ,
	CONSTRAINT "CourseComponent_pkey" PRIMARY KEY ( "courseComponentID" )
 );

CREATE TABLE "coursePolicy" ( 
	"coursePolicyID"     integer  NOT NULL,
	"coursePolicyTitle"  varchar( 255 )  ,
	"coursePolicyDescription" text  ,
	"userID"             integer  NOT NULL,
	"coursePolicyCategoryID" integer  NOT NULL,
	CONSTRAINT "coursePolicy_pkey" PRIMARY KEY ( "coursePolicyID" ),
	CONSTRAINT "coursePolicy_coursePolicyCategoryID_fkey" FOREIGN KEY ( "coursePolicyCategoryID" ) REFERENCES "coursePolicyCategory"( "coursePolicyCategoryID" )    ,
	CONSTRAINT "coursePolicy_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
 );

CREATE TABLE imod ( 
	"imodID"             integer  NOT NULL,
	"imodTitle"          varchar( 255 )  ,
	"imodUrl"            varchar( 255 )  ,
	"imodOverview"       text  ,
	"courseSemester"     varchar( 255 )  ,
	"courseLocation"     varchar( 255 )  ,
	"timeRatio"          varchar( 100 )  ,
	"userID"             integer  NOT NULL,
	"numberOfSeats"      integer  ,
	"subjectArea"        varchar( 255 )  ,
	"creditHours"        integer  ,
	"imodNumber"         varchar( 50 )  ,
	CONSTRAINT imod_pkey PRIMARY KEY ( "imodID" ),
	CONSTRAINT "imod_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
 );

CREATE INDEX i-modContext_UserID_idx ON imod ( "userID" );

CREATE TABLE "imodCoursePolicy" ( 
	"imodID"             integer  NOT NULL,
	"coursePolicyID"     integer  NOT NULL,
	CONSTRAINT "imodCoursePolicy_coursePolicyID_fkey" FOREIGN KEY ( "coursePolicyID" ) REFERENCES "coursePolicy"( "coursePolicyID" )    ,
	CONSTRAINT "imodCoursePolicy_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES imod( "imodID" )    
 );

CREATE TABLE instructor ( 
	"instructorID"       integer  NOT NULL,
	"instructorName"     varchar( 255 )  ,
	location             varchar( 255 )  ,
	"emailID"            varchar( 255 )  ,
	"phoneNumber"        varchar( 255 )  ,
	"officeHours"        varchar( 255 )  ,
	"webPage"            varchar( 255 )  ,
	CONSTRAINT instructor_pkey PRIMARY KEY ( "instructorID" )
 );

CREATE TABLE "instructorPhoneNumber" ( 
	"instructorID"       integer  NOT NULL,
	"phoneNumber"        varchar( 255 )  ,
	"phoneType"          varchar( 255 )  ,
	CONSTRAINT "instructorPhoneNumber_instructorID_fkey" FOREIGN KEY ( "instructorID" ) REFERENCES instructor( "instructorID" )    
 );

CREATE TABLE "imodInstructor" ( 
	"instructorID"       integer  NOT NULL,
	"imodID"             integer  NOT NULL,
	CONSTRAINT "imodInstructor_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES imod( "imodID" )    ,
	CONSTRAINT "imodInstructor_instructorID_fkey" FOREIGN KEY ( "instructorID" ) REFERENCES instructor( "instructorID" )    
 );

