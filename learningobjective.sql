CREATE SCHEMA public;

CREATE TABLE help ( 
	"helpID"             integer  NOT NULL,
	"helpItemID"         varchar( 255 )  ,
	"helpText"           varchar( 255 )  ,
	CONSTRAINT help_pkey PRIMARY KEY ( "helpID" )
 );

CREATE TABLE "learningDomain" ( 
	"domainID"           integer  NOT NULL,
	"domainName"         varchar( 255 )  ,
	CONSTRAINT "learningDomain_pkey" PRIMARY KEY ( "domainID" )
 );

CREATE TABLE "actionWord" ( 
	"actionID"           integer  NOT NULL,
	"categoryID"         integer  NOT NULL,
	visibility           varchar( 255 )  ,
	"actionWord"         varchar( 255 )  ,
	"userID"             integer  NOT NULL,
	"domainID"           integer  NOT NULL,
	CONSTRAINT "ActionWords_pkey" PRIMARY KEY ( "actionID" ),
	CONSTRAINT "actionWord_domainID_fkey1" FOREIGN KEY ( "domainID" ) REFERENCES "learningDomain"( "domainID" )    ,
	CONSTRAINT "actionWord_userID_fkey" FOREIGN KEY ( "userID" ) REFERENCES user( "userID" )    
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

CREATE TABLE "learningObjective" ( 
	"learningObjectiveID" integer  NOT NULL,
	"imodID"             integer  NOT NULL,
	condition            varchar( 255 )  ,
	performance          varchar( 255 )  ,
	criteria             varchar( 255 )  ,
	"learningDomain"     varchar( 255 )  ,
	"domainCategory"     varchar( 255 )  ,
	"completeLearningObjective" varchar( 255 )  ,
	"contentID"          integer  NOT NULL,
	indicator            varchar( 255 )  ,
	"actionID"           integer  NOT NULL,
	"criteriaType"       integer  NOT NULL,
	CONSTRAINT "LearningObjetives_pkey" PRIMARY KEY ( "learningObjectiveID" ),
	CONSTRAINT "actionID_fkey" FOREIGN KEY ( "actionID" ) REFERENCES "actionWord"( "actionID" )    ,
	CONSTRAINT "learningObjetive_contentID_fkey" FOREIGN KEY ( "contentID" ) REFERENCES content( "contentID" )    ,
	CONSTRAINT "learningObjetive_imodID_fkey" FOREIGN KEY ( "imodID" ) REFERENCES imod( "imodID" )    ,
	CONSTRAINT "learningObjective_criteriaType_fkey" FOREIGN KEY ( "criteriaType" ) REFERENCES "learningObjectiveCriteriaType"( "criteriaTypeID" )    
 );

CREATE INDEX fki_actionID_fkey ON "learningObjective" ( "actionID" );

