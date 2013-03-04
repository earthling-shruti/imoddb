CREATE SCHEMA public;

CREATE TABLE "audience" ( 
	"audienceID"         integer  NOT NULL,
	"audienceDescription" text  ,
	CONSTRAINT "Audience_pkey" PRIMARY KEY ( "audienceID" )
 );

CREATE TABLE "componentDesignation" ( 
	"designationID"      integer  NOT NULL,
	"designationDescription" varchar( 255 )  ,
	CONSTRAINT "ComponentDesignation_pkey" PRIMARY KEY ( "designationID" )
 );

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

CREATE TABLE "courseComponentCode" ( 
	"courseComponentID"  integer  NOT NULL,
	"courseComponentDescription" text  ,
	CONSTRAINT "CourseComponent_pkey" PRIMARY KEY ( "courseComponentID" )
 );

CREATE TABLE "coursePolicyCategory" ( 
	"coursePolicyCategoryID" integer  NOT NULL,
	"coursePolicyCategoryTitle" integer  ,
	CONSTRAINT "coursePolicyCategory_pkey" PRIMARY KEY ( "coursePolicyCategoryID" )
 );

CREATE TABLE "help" ( 
	"helpID"             integer  NOT NULL,
	"helpItemID"         varchar( 255 )  ,
	"helpText"           varchar( 255 )  ,
	CONSTRAINT "help_pkey" PRIMARY KEY ( "helpID" )
 );

CREATE TABLE "imodCourseComponent" ( 
	"imodID"             integer  NOT NULL,
	"courseComponentID"  integer  NOT NULL,
	"designationID"      integer DEFAULT 2 NOT NULL,
	CONSTRAINT "imodCourseComponent_pkey" PRIMARY KEY ( "imodID" ),
	CONSTRAINT "imodCourseComponent_designationID_fkey" FOREIGN KEY ( "designationID" ) REFERENCES "componentDesignation"( "designationID" )    ,
	CONSTRAINT "imodCourseComponent_courseComponentID_fkey" FOREIGN KEY ( "courseComponentID" ) REFERENCES "courseComponentCode"( "courseComponentID" )    
 );

CREATE TABLE "instructor" ( 
	"instructorID"       integer  NOT NULL,
	"instructorName"     varchar( 255 )  ,
	"location"           varchar( 255 )  ,
	"emailID"            varchar( 255 )  ,
	"phoneNumber"        varchar( 255 )  ,
	"officeHours"        varchar( 255 )  ,
	"webPage"            varchar( 255 )  ,
	CONSTRAINT "instructor_pkey" PRIMARY KEY ( "instructorID" )
 );

CREATE TABLE "instructorPhoneNumber" ( 
	"instructorID"       integer  NOT NULL,
	"phoneNumber"        varchar( 255 )  ,
	"phoneType"          varchar( 255 )  ,
	CONSTRAINT "instructorPhoneNumber_instructorID_fkey" FOREIGN KEY ( "instructorID" ) REFERENCES "instructor"( "instructorID" )    
 );

CREATE TABLE "learningDomain" ( 
	"domainID"           integer  NOT NULL,
	"domainName"         varchar( 255 )  ,
	CONSTRAINT "learningDomain_pkey" PRIMARY KEY ( "domainID" )
 );

CREATE TABLE "learningObjectiveCriteriaType" ( 
	"criteriaTypeID"     integer  NOT NULL,
	"criteriaTypeDescription" text  ,
	CONSTRAINT "learningObjectiveCriteriaType_pkey" PRIMARY KEY ( "criteriaTypeID" )
 );

CREATE TABLE "userRole" ( 
	"userRoleID"         integer  NOT NULL,
	"userRoleDescription" varchar( 255 )  ,
	CONSTRAINT "userRole_pkey" PRIMARY KEY ( "userRoleID" )
 );

CREATE TABLE "domainCategory" ( 
	"domainID"           integer  NOT NULL,
	"categoryID"         integer  NOT NULL,
	"categoryName"       varchar( 255 )  ,
	CONSTRAINT "domainCategory_pkey" PRIMARY KEY ( "domainID", "categoryID" ),
	CONSTRAINT "domainID_fkey" FOREIGN KEY ( "domainID" ) REFERENCES "learningDomain"( "domainID" )    
 );

CREATE INDEX DomainCategories_CategoryID_idx ON "domainCategory" ( "categoryID" );

CREATE INDEX fki_domainID_fkey ON "domainCategory" ( "domainID" );

CREATE TABLE "user" ( 
	"userID"             integer  NOT NULL,
	"userName"           varchar( 255 )  NOT NULL,
	"password"           varchar( 255 )  NOT NULL,
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
	"organization"       varchar( 255 )  ,
	"themeCode"          varchar( 255 )  ,
	"fullName"           varchar( 255 )  ,
	"streetAddress"      varchar( 255 )  ,
	"city"               varchar( 255 )  ,
	"state"              varchar( 255 )  ,
	"country"            varchar( 255 )  ,
	"zip"                varchar( 50 )  ,
	CONSTRAINT "userID" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
 );

CREATE INDEX fki_userID ON "userProfile" ( "userID" );

CREATE TABLE "actionWord" ( 
	"actionID"           integer  NOT NULL,
	"categoryID"         integer  NOT NULL,
	"visibility"         varchar( 255 )  ,
	"actionWord"         varchar( 255 )  ,
	"userID"             integer  NOT NULL,
	"domainID"           integer  NOT NULL,
	CONSTRAINT "ActionWords_pkey" PRIMARY KEY ( "actionID" ),
	CONSTRAINT "actionWord_domainID_fkey1" FOREIGN KEY ( "domainID" ) REFERENCES "learningDomain"( "domainID" )    ,
	CONSTRAINT "actionWord_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
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

CREATE TABLE "imod" ( 
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
	CONSTRAINT "imod_pkey" PRIMARY KEY ( "imodID" ),
	CONSTRAINT "imod_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
 );

CREATE INDEX i-modContext_UserID_idx ON "imod" ( "userID" );

CREATE TABLE "imodAudience" ( 
	"imodID"             integer  NOT NULL,
	"audienceID"         integer  NOT NULL,
	CONSTRAINT "audienceID_pkey" FOREIGN KEY ( "audienceID" ) REFERENCES "audience"( "audienceID" )    ,
	CONSTRAINT "imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" )    
 );

CREATE INDEX fki_audienceID_pkey ON "imodAudience" ( "audienceID" );

CREATE INDEX fki_imodID_fkey ON "imodAudience" ( "imodID" );

CREATE TABLE "imodCoursePolicy" ( 
	"imodID"             integer  NOT NULL,
	"coursePolicyID"     integer  NOT NULL,
	CONSTRAINT "imodCoursePolicy_coursePolicyID_fkey" FOREIGN KEY ( "coursePolicyID" ) REFERENCES "coursePolicy"( "coursePolicyID" )    ,
	CONSTRAINT "imodCoursePolicy_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" )    
 );

CREATE TABLE "imodInstructor" ( 
	"instructorID"       integer  NOT NULL,
	"imodID"             integer  NOT NULL,
	CONSTRAINT "imodInstructor_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" )    ,
	CONSTRAINT "imodInstructor_instructorID_fkey" FOREIGN KEY ( "instructorID" ) REFERENCES "instructor"( "instructorID" )    
 );

CREATE TABLE "pieChart" ( 
	"imodID"             integer  NOT NULL,
	"count"              integer  ,
	"priority"           integer  NOT NULL,
	CONSTRAINT "pieChart_priority_fkey" FOREIGN KEY ( "priority" ) REFERENCES "contentPriorityCode"( "priorityID" )    ,
	CONSTRAINT "pieChart_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" )    
 );

CREATE TABLE "schedule" ( 
	"imodID"             integer  NOT NULL,
	"repeats"            varchar( 255 )  ,
	"repeatsEvery"       varchar( 10 )  ,
	"repeatsDays"        varchar( 15 )  ,
	"startDate"          varchar( 15 )  ,
	"endDate"            varchar( 15 )  ,
	"endOccurrences"     integer  ,
	"monday"             integer  ,
	"tuesday"            integer  ,
	"wednesday"          integer  ,
	"thursday"           integer  ,
	"friday"             integer  ,
	"saturday"           integer  ,
	"sunday"             integer  ,
	CONSTRAINT "schedule_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" )    
 );

CREATE TABLE "scheduleDate" ( 
	"imodID"             integer  NOT NULL,
	"date"               varchar( 255 )  ,
	CONSTRAINT "scheduleDates_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" )    
 );

CREATE INDEX "fki_imodID" ON "scheduleDate" ( "imodID" );

CREATE TABLE "content" ( 
	"contentID"          integer  NOT NULL,
	"learningObjectiveID" integer  NOT NULL,
	"topicTitle"         varchar( 255 )  ,
	"priorityID"         integer  NOT NULL,
	CONSTRAINT "Content_pkey" PRIMARY KEY ( "contentID" )
 );

CREATE INDEX "fki_LearningObjectiveID" ON "content" ( "learningObjectiveID" );

CREATE TABLE "contentHeirarchy" ( 
	"hierarchyID"        integer  NOT NULL,
	"parentContentID"    integer  NOT NULL,
	"leafContentID"      integer  NOT NULL,
	CONSTRAINT "ContentHeirarchy_pkey" PRIMARY KEY ( "hierarchyID" )
 );

CREATE INDEX "fki_leafContentID" ON "contentHeirarchy" ( "leafContentID" );

CREATE INDEX "fki_parentContentID" ON "contentHeirarchy" ( "parentContentID" );

CREATE TABLE "contentResource" ( 
	"contentResourceID"  integer  NOT NULL,
	"contentID"          integer  NOT NULL,
	"contentResourceTitle" varchar( 255 )  ,
	"contentResourceType" integer  NOT NULL,
	CONSTRAINT "Resource_pkey" PRIMARY KEY ( "contentResourceID" )
 );

CREATE INDEX "Resource_ContentID_idx" ON "contentResource" ( "contentID" );

CREATE TABLE "imodContent" ( 
	"imodID"             integer  NOT NULL,
	"contentID"          integer  NOT NULL,
	CONSTRAINT "imodContent_pkey" PRIMARY KEY ( "imodID", "contentID" )
 );

CREATE INDEX "fki_contentID_fkey" ON "imodContent" ( "contentID" );

CREATE INDEX "fki_imod_id_fkey" ON "imodContent" ( "imodID" );

CREATE TABLE "learningObjective" ( 
	"learningObjectiveID" integer  NOT NULL,
	"imodID"             integer  NOT NULL,
	"condition"          varchar( 255 )  ,
	"performance"        varchar( 255 )  ,
	"criteria"           varchar( 255 )  ,
	"learningDomain"     varchar( 255 )  ,
	"domainCategory"     varchar( 255 )  ,
	"completeLearningObjective" varchar( 255 )  ,
	"contentID"          integer  NOT NULL,
	"indicator"          varchar( 255 )  ,
	"actionID"           integer  NOT NULL,
	"criteriaType"       integer  NOT NULL,
	CONSTRAINT "LearningObjetives_pkey" PRIMARY KEY ( "learningObjectiveID" )
 );

CREATE INDEX "fki_actionID_fkey" ON "learningObjective" ( "actionID" );

ALTER TABLE "content" ADD CONSTRAINT "content_priorityID_fkey" FOREIGN KEY ( "priorityID" ) REFERENCES "contentPriorityCode"( "priorityID" );

ALTER TABLE "content" ADD CONSTRAINT "content_learningObjectiveID_fkey" FOREIGN KEY ( "learningObjectiveID" ) REFERENCES "learningObjective"( "learningObjectiveID" );

ALTER TABLE "contentHeirarchy" ADD CONSTRAINT "leafContentID" FOREIGN KEY ( "leafContentID" ) REFERENCES "content"( "contentID" );

ALTER TABLE "contentHeirarchy" ADD CONSTRAINT "parentContentID" FOREIGN KEY ( "parentContentID" ) REFERENCES "content"( "contentID" );

ALTER TABLE "contentResource" ADD CONSTRAINT "contentResource_contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES "content"( "contentID" );

ALTER TABLE "contentResource" ADD CONSTRAINT "contentResource_contentResourceType_fkey" FOREIGN KEY ( "contentResourceType" ) REFERENCES "contentResourceType"( "contentResourceTypeID" );

ALTER TABLE "imodContent" ADD CONSTRAINT "contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES "content"( "contentID" );

ALTER TABLE "imodContent" ADD CONSTRAINT "imod_id_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" );

ALTER TABLE "learningObjective" ADD CONSTRAINT "actionID_fkey" FOREIGN KEY ( "actionID" ) REFERENCES "actionWord"( "actionID" );

ALTER TABLE "learningObjective" ADD CONSTRAINT "learningObjetive_contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES "content"( "contentID" );

ALTER TABLE "learningObjective" ADD CONSTRAINT "learningObjetive_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES "imod"( "imodID" );

ALTER TABLE "learningObjective" ADD CONSTRAINT "learningObjective_criteriaType_fkey" FOREIGN KEY ( "criteriaType" ) REFERENCES "learningObjectiveCriteriaType"( "criteriaTypeID" );

