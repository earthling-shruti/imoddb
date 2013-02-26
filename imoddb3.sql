CREATE SCHEMA public;

CREATE TABLE public.audience ( 
	"audienceID"         integer  NOT NULL,
	"audienceDescription" text  NOT NULL,
	CONSTRAINT "Audience_pkey" PRIMARY KEY ( "audienceID" )
 );

CREATE TABLE public."componentDesignation" ( 
	"designationID"      integer  NOT NULL,
	"designationDescription" char( 255 )  NOT NULL,
	CONSTRAINT "ComponentDesignation_pkey" PRIMARY KEY ( "designationID" )
 );

CREATE TABLE public."contentPriorityCode" ( 
	"priorityID"         integer  NOT NULL,
	"priorityDescription" text  NOT NULL,
	CONSTRAINT "contentPriorityCode_pkey" PRIMARY KEY ( "priorityID" )
 );

CREATE TABLE public."contentResource" ( 
	"contentResourceID"  integer  NOT NULL,
	"contentID"          integer  NOT NULL,
	"contentResourceTitle" varchar( 255 )  NOT NULL,
	"contentResourceType" varchar( 255 )  NOT NULL,
	CONSTRAINT "Resource_pkey" PRIMARY KEY ( "contentResourceID" )
 );

CREATE INDEX Resource_ContentID_idx ON public."contentResource" ( "contentID" );

CREATE TABLE public."courseComponentCode" ( 
	"courseComponentID"  integer  NOT NULL,
	"courseComponentDescription" text  NOT NULL,
	CONSTRAINT "CourseComponent_pkey" PRIMARY KEY ( "courseComponentID" )
 );

CREATE TABLE public."coursePolicyCategory" ( 
	"coursePolicyCategoryID" integer  NOT NULL,
	"coursePolicyCategoryTitle" integer  NOT NULL,
	CONSTRAINT "coursePolicyCategory_pkey" PRIMARY KEY ( "coursePolicyCategoryID" )
 );

CREATE TABLE public.help ( 
	"helpID"             integer  NOT NULL,
	"helpItemID"         varchar( 255 )  NOT NULL,
	"helpText"           varchar( 255 )  NOT NULL,
	CONSTRAINT help_pkey PRIMARY KEY ( "helpID" )
 );

CREATE TABLE public."imodCourseComponent" ( 
	"imodID"             integer  NOT NULL,
	"courseComponentID"  integer  NOT NULL,
	"designationID"      integer DEFAULT 2 NOT NULL,
	CONSTRAINT "imodCourseComponent_pkey" PRIMARY KEY ( "imodID" ),
	CONSTRAINT "imodCourseComponent_designationID_fkey" FOREIGN KEY ( "designationID" ) REFERENCES public."componentDesignation"( "designationID" )    ,
	CONSTRAINT "imodCourseComponent_courseComponentID_fkey" FOREIGN KEY ( "courseComponentID" ) REFERENCES public."courseComponentCode"( "courseComponentID" )    
 );

CREATE TABLE public.instructor ( 
	"instructorID"       integer  NOT NULL,
	"instructorName"     char( 255 )  NOT NULL,
	location             char( 255 )  NOT NULL,
	"emailID"            char( 255 )  NOT NULL,
	"phoneNumber"        varchar( 255 )  NOT NULL,
	"officeHours"        char( 255 )  NOT NULL,
	"webPage"            char( 255 )  NOT NULL,
	CONSTRAINT instructor_pkey PRIMARY KEY ( "instructorID" )
 );

CREATE TABLE public."instructorPhoneNumber" ( 
	"instructorID"       integer  NOT NULL,
	"phoneNumber"        char( 255 )  NOT NULL,
	"phoneType"          char( 255 )  NOT NULL,
	CONSTRAINT "instructorPhoneNumber_instructorID_fkey" FOREIGN KEY ( "instructorID" ) REFERENCES public.instructor( "instructorID" )    
 );

CREATE TABLE public."learningDomain" ( 
	"domainID"           varchar( 255 )  NOT NULL,
	"domainName"         varchar( 255 )  NOT NULL,
	CONSTRAINT "LearningDomains_pkey" PRIMARY KEY ( "domainID" )
 );

CREATE TABLE public."userRole" ( 
	"userRoleID"         integer  NOT NULL,
	"userRoleDescription" varchar( 255 )  ,
	CONSTRAINT "userRole_pkey" PRIMARY KEY ( "userRoleID" )
 );

CREATE TABLE public."domainCategory" ( 
	"categoryID"         integer  NOT NULL,
	"domainID"           varchar( 255 )  NOT NULL,
	"categoryName"       varchar( 255 )  NOT NULL,
	CONSTRAINT "domainCategories_pkey" PRIMARY KEY ( "categoryID" ),
	CONSTRAINT "domainCategories_domainID_fkey" FOREIGN KEY ( "domainID" ) REFERENCES public."learningDomain"( "domainID" )    
 );

CREATE INDEX fki_DomainID ON public."domainCategory" ( "domainID" );

CREATE TABLE public.user ( 
	"userID"             integer  NOT NULL,
	"userName"           char( 255 )  NOT NULL,
	password             char( 255 )  NOT NULL,
	"emailID"            varchar( 255 )  NOT NULL,
	"fullName"           char( 255 )  NOT NULL,
	"userRoleID"         integer  NOT NULL,
	CONSTRAINT "User_pkey" PRIMARY KEY ( "userID" ),
	CONSTRAINT "User_UserName_key" UNIQUE ( "userName" ) ,
	CONSTRAINT "userRoleID" FOREIGN KEY ( "userRoleID" ) REFERENCES public."userRole"( "userRoleID" )    
 );

CREATE INDEX fki_userRoleID ON public.user ( "userRoleID" );

CREATE TABLE public."userProfile" ( 
	"userID"             integer  NOT NULL,
	organization         varchar( 255 )  NOT NULL,
	"themeCode"          varchar( 255 )  NOT NULL,
	"fullName"           varchar( 255 )  NOT NULL,
	"streetAddress"      varchar( 255 )  NOT NULL,
	city                 varchar( 255 )  NOT NULL,
	state                varchar( 255 )  NOT NULL,
	zip                  integer  NOT NULL,
	country              varchar( 255 )  NOT NULL,
	CONSTRAINT "userID" FOREIGN KEY ( "userID" ) REFERENCES public.user( "userID" )    
 );

CREATE INDEX fki_userID ON public."userProfile" ( "userID" );

CREATE TABLE public."actionWord" ( 
	"actionID"           integer  NOT NULL,
	"categoryID"         integer  NOT NULL,
	visibility           varchar( 2147483647 )  NOT NULL,
	"actionWord"         varchar( 255 )  NOT NULL,
	"userID"             integer  NOT NULL,
	CONSTRAINT "ActionWords_pkey" PRIMARY KEY ( "actionID" ),
	CONSTRAINT "actionWords_userID_fkey1" FOREIGN KEY ( "userID" ) REFERENCES public.user( "userID" )    
 );

CREATE TABLE public."coursePolicy" ( 
	"coursePolicyID"     integer  NOT NULL,
	"coursePolicyTitle"  char( 255 )  NOT NULL,
	"coursePolicyDescription" text  NOT NULL,
	"userID"             integer  NOT NULL,
	"coursePolicyCategoryID" integer  NOT NULL,
	CONSTRAINT "coursePolicy_pkey" PRIMARY KEY ( "coursePolicyID" ),
	CONSTRAINT "coursePolicy_coursePolicyCategoryID_fkey" FOREIGN KEY ( "coursePolicyCategoryID" ) REFERENCES public."coursePolicyCategory"( "coursePolicyCategoryID" )    ,
	CONSTRAINT "coursePolicy_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES public.user( "userID" )    
 );

CREATE TABLE public.imod ( 
	"imodID"             integer  NOT NULL,
	"imodNumber"         integer  NOT NULL,
	"imodTitle"          char( 255 )  NOT NULL,
	"imodUrl"            char( 255 )  NOT NULL,
	"imodOverview"       text  NOT NULL,
	"courseSemester"     varchar( 255 )  NOT NULL,
	"courseLocation"     varchar( 255 )  NOT NULL,
	"timeRatio"          varchar( 100 )  NOT NULL,
	"userID"             integer  NOT NULL,
	"numberOfSeats"      integer  NOT NULL,
	"subjectArea"        char( 255 )  NOT NULL,
	"creditHours"        integer  NOT NULL,
	CONSTRAINT imod_pkey PRIMARY KEY ( "imodID" ),
	CONSTRAINT "imod_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES public.user( "userID" )    
 );

CREATE INDEX i-modContext_UserID_idx ON public.imod ( "userID" );

CREATE TABLE public."imodAudience" ( 
	"imodID"             integer  NOT NULL,
	"audienceID"         integer  NOT NULL,
	CONSTRAINT "audienceID_pkey" FOREIGN KEY ( "audienceID" ) REFERENCES public.audience( "audienceID" )    ,
	CONSTRAINT "imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" )    
 );

CREATE INDEX fki_audienceID_pkey ON public."imodAudience" ( "audienceID" );

CREATE INDEX fki_imodID_fkey ON public."imodAudience" ( "imodID" );

CREATE TABLE public."imodCoursePolicy" ( 
	"imodID"             integer  NOT NULL,
	"coursePolicyID"     integer  NOT NULL,
	CONSTRAINT "imodCoursePolicy_coursePolicyID_fkey" FOREIGN KEY ( "coursePolicyID" ) REFERENCES public."coursePolicy"( "coursePolicyID" )    ,
	CONSTRAINT "imodCoursePolicy_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" )    
 );

CREATE TABLE public."imodInstructor" ( 
	"instructorID"       integer  NOT NULL,
	"imodID"             integer  NOT NULL,
	CONSTRAINT "imodInstructor_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" )    ,
	CONSTRAINT "imodInstructor_instructorID_fkey" FOREIGN KEY ( "instructorID" ) REFERENCES public.instructor( "instructorID" )    
 );

CREATE TABLE public."pieChart" ( 
	"imodID"             integer  NOT NULL,
	priority             varchar( 255 )  NOT NULL,
	count                integer  NOT NULL,
	CONSTRAINT "pieChart_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" )    
 );

CREATE TABLE public.schedule ( 
	"imodID"             integer  NOT NULL,
	repeats              varchar( 255 )  NOT NULL,
	"repeatsEvery"       varchar( 10 )  NOT NULL,
	"repeatsDays"        varchar( 15 )  NOT NULL,
	"startDate"          varchar( 15 )  NOT NULL,
	"endDate"            varchar( 15 )  NOT NULL,
	"endOccurrences"     integer  NOT NULL,
	monday               integer  NOT NULL,
	tuesday              integer  NOT NULL,
	wednesday            integer  NOT NULL,
	thursday             integer  NOT NULL,
	friday               integer  NOT NULL,
	saturday             integer  NOT NULL,
	CONSTRAINT "schedule_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" )    
 );

CREATE TABLE public."scheduleDate" ( 
	"imodID"             integer  NOT NULL,
	date                 varchar( 255 )  NOT NULL,
	CONSTRAINT "scheduleDates_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" )    
 );

CREATE INDEX fki_imodID ON public."scheduleDate" ( "imodID" );

CREATE TABLE public.content ( 
	"contentID"          integer  NOT NULL,
	"learningObjectiveID" integer  NOT NULL,
	"topicTitle"         varchar( 255 )  NOT NULL,
	"priorityID"         integer  NOT NULL,
	CONSTRAINT "Content_pkey" PRIMARY KEY ( "contentID" )
 );

CREATE INDEX fki_LearningObjectiveID ON public.content ( "learningObjectiveID" );

CREATE TABLE public."contentHeirarchy" ( 
	"hierarchyID"        integer  NOT NULL,
	"parentContentID"    integer  NOT NULL,
	"leafContentID"      integer  NOT NULL,
	CONSTRAINT "ContentHeirarchy_pkey" PRIMARY KEY ( "hierarchyID" )
 );

CREATE INDEX fki_leafContentID ON public."contentHeirarchy" ( "leafContentID" );

CREATE INDEX fki_parentContentID ON public."contentHeirarchy" ( "parentContentID" );

CREATE TABLE public."imodContent" ( 
	"imodID"             integer  NOT NULL,
	"contentID"          integer  NOT NULL
 );

CREATE INDEX fki_contentID_fkey ON public."imodContent" ( "contentID" );

CREATE INDEX fki_imod_id_fkey ON public."imodContent" ( "imodID" );

CREATE TABLE public."learningObjetive" ( 
	"learningObjectiveID" integer  NOT NULL,
	"imodID"             integer  NOT NULL,
	condition            varchar( 255 )  NOT NULL,
	performance          varchar( 255 )  NOT NULL,
	content              varchar( 255 )  NOT NULL,
	criteria             varchar( 255 )  NOT NULL,
	"learningDomain"     varchar( 255 )  NOT NULL,
	"domainCategory"     varchar( 255 )  NOT NULL,
	"completeLearningObjective" varchar( 255 )  NOT NULL,
	"contentID"          integer  NOT NULL,
	"performanceID"      integer  NOT NULL,
	indicator            varchar( 255 )  NOT NULL,
	"criteriaType"       varchar( 255 )  NOT NULL,
	CONSTRAINT "LearningObjetives_pkey" PRIMARY KEY ( "learningObjectiveID" )
 );

ALTER TABLE public.content ADD CONSTRAINT "content_priorityID_fkey" FOREIGN KEY ( "priorityID" ) REFERENCES public."contentPriorityCode"( "priorityID" );

ALTER TABLE public.content ADD CONSTRAINT "content_learningObjectiveID_fkey" FOREIGN KEY ( "learningObjectiveID" ) REFERENCES public."learningObjetive"( "learningObjectiveID" );

ALTER TABLE public."contentHeirarchy" ADD CONSTRAINT "leafContentID" FOREIGN KEY ( "leafContentID" ) REFERENCES public.content( "contentID" );

ALTER TABLE public."contentHeirarchy" ADD CONSTRAINT "parentContentID" FOREIGN KEY ( "parentContentID" ) REFERENCES public.content( "contentID" );

ALTER TABLE public."imodContent" ADD CONSTRAINT "contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES public.content( "contentID" );

ALTER TABLE public."imodContent" ADD CONSTRAINT imod_id_fkey FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" );

ALTER TABLE public."learningObjetive" ADD CONSTRAINT "learningObjetive_contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES public.content( "contentID" );

ALTER TABLE public."learningObjetive" ADD CONSTRAINT "learningObjetive_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES public.imod( "imodID" );

