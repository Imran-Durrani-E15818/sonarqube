CREATE TABLE "ORGANIZATIONS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "KEE" VARCHAR(32) NOT NULL,
  "NAME" VARCHAR(64) NOT NULL,
  "DESCRIPTION" VARCHAR(256),
  "URL" VARCHAR(256),
  "AVATAR_URL" VARCHAR(256),
  "GUARDED" BOOLEAN NOT NULL,
  "USER_ID" INTEGER,
  "DEFAULT_PERM_TEMPLATE_PROJECT" VARCHAR(40),
  "DEFAULT_PERM_TEMPLATE_VIEW" VARCHAR(40),
  "DEFAULT_GROUP_ID" INTEGER,
  "DEFAULT_QUALITY_GATE_UUID" VARCHAR(40) NOT NULL,
  "NEW_PROJECT_PRIVATE" BOOLEAN NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "PK_ORGANIZATIONS" ON "ORGANIZATIONS" ("UUID");
CREATE UNIQUE INDEX "ORGANIZATION_KEY" ON "ORGANIZATIONS" ("KEE");

CREATE TABLE "ORGANIZATION_MEMBERS" (
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "USER_ID" INTEGER NOT NULL
);
CREATE PRIMARY KEY ON "ORGANIZATION_MEMBERS" ("ORGANIZATION_UUID", "USER_ID");

CREATE TABLE "GROUPS_USERS" (
  "USER_ID" INTEGER,
  "GROUP_ID" INTEGER
);
CREATE INDEX "INDEX_GROUPS_USERS_ON_GROUP_ID" ON "GROUPS_USERS" ("GROUP_ID");
CREATE INDEX "INDEX_GROUPS_USERS_ON_USER_ID" ON "GROUPS_USERS" ("USER_ID");
CREATE UNIQUE INDEX "GROUPS_USERS_UNIQUE" ON "GROUPS_USERS" ("GROUP_ID", "USER_ID");


CREATE TABLE "RULES_PARAMETERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "RULE_ID" INTEGER NOT NULL,
  "NAME" VARCHAR(128) NOT NULL,
  "PARAM_TYPE" VARCHAR(512) NOT NULL,
  "DEFAULT_VALUE" VARCHAR(4000),
  "DESCRIPTION" VARCHAR(4000)
);
CREATE INDEX "RULES_PARAMETERS_RULE_ID" ON "RULES_PARAMETERS" ("RULE_ID");


CREATE TABLE "RULES_PROFILES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(100) NOT NULL,
  "LANGUAGE" VARCHAR(20),
  "KEE" VARCHAR(255) NOT NULL,
  "RULES_UPDATED_AT" VARCHAR(100),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
  "IS_BUILT_IN" BOOLEAN NOT NULL
);
CREATE UNIQUE INDEX "UNIQ_QPROF_KEY" ON "RULES_PROFILES" ("KEE");


CREATE TABLE "ORG_QPROFILES" (
  "UUID" VARCHAR(255) NOT NULL PRIMARY KEY,
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "RULES_PROFILE_UUID" VARCHAR(255) NOT NULL,
  "PARENT_UUID" VARCHAR(255),
  "LAST_USED" BIGINT,
  "USER_UPDATED_AT" BIGINT,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE INDEX "ORG_QPROFILES_ORG_UUID" ON "ORG_QPROFILES" ("ORGANIZATION_UUID");
CREATE INDEX "ORG_QPROFILES_RP_UUID" ON "ORG_QPROFILES" ("RULES_PROFILE_UUID");


CREATE TABLE "DEFAULT_QPROFILES" (
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "LANGUAGE" VARCHAR(20) NOT NULL,
  "QPROFILE_UUID" VARCHAR(255) NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE PRIMARY KEY ON "DEFAULT_QPROFILES" ("ORGANIZATION_UUID", "LANGUAGE");
CREATE UNIQUE INDEX "UNIQ_DEFAULT_QPROFILES_UUID" ON "DEFAULT_QPROFILES" ("QPROFILE_UUID");


CREATE TABLE "PROJECT_QPROFILES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "PROFILE_KEY" VARCHAR(255) NOT NULL
);
CREATE UNIQUE INDEX "UNIQ_PROJECT_QPROFILES" ON "PROJECT_QPROFILES" ("PROJECT_UUID", "PROFILE_KEY");


CREATE TABLE "QPROFILE_EDIT_USERS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "USER_ID" INTEGER NOT NULL,
  "QPROFILE_UUID" VARCHAR(255) NOT NULL,
  "CREATED_AT" BIGINT,
);
CREATE UNIQUE INDEX "PK_QPROFILE_EDIT_USERS" ON "QPROFILE_EDIT_USERS" ("UUID");
CREATE INDEX "QPROFILE_EDIT_USERS_QPROFILE" ON "QPROFILE_EDIT_USERS" ("QPROFILE_UUID");
CREATE UNIQUE INDEX "QPROFILE_EDIT_USERS_UNIQUE" ON "QPROFILE_EDIT_USERS" ("USER_ID", "QPROFILE_UUID");


CREATE TABLE "QPROFILE_EDIT_GROUPS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "GROUP_ID" INTEGER NOT NULL,
  "QPROFILE_UUID" VARCHAR(255) NOT NULL,
  "CREATED_AT" BIGINT,
);
CREATE UNIQUE INDEX "PK_QPROFILE_EDIT_GROUPS" ON "QPROFILE_EDIT_GROUPS" ("UUID");
CREATE INDEX "QPROFILE_EDIT_GROUPS_QPROFILE" ON "QPROFILE_EDIT_GROUPS" ("QPROFILE_UUID");
CREATE UNIQUE INDEX "QPROFILE_EDIT_GROUPS_UNIQUE" ON "QPROFILE_EDIT_GROUPS" ("GROUP_ID", "QPROFILE_UUID");


CREATE TABLE "GROUPS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "NAME" VARCHAR(500),
  "DESCRIPTION" VARCHAR(200),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);


CREATE TABLE "SNAPSHOTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(50) NOT NULL,
  "CREATED_AT" BIGINT,
  "BUILD_DATE" BIGINT,
  "COMPONENT_UUID" VARCHAR(50) NOT NULL,
  "STATUS" VARCHAR(4) NOT NULL DEFAULT 'U',
  "PURGE_STATUS" INTEGER,
  "ISLAST" BOOLEAN NOT NULL DEFAULT FALSE,
  "VERSION" VARCHAR(500),
  "PERIOD1_MODE" VARCHAR(100),
  "PERIOD1_PARAM" VARCHAR(100),
  "PERIOD1_DATE" BIGINT,
  "PERIOD2_MODE" VARCHAR(100),
  "PERIOD2_PARAM" VARCHAR(100),
  "PERIOD2_DATE" BIGINT,
  "PERIOD3_MODE" VARCHAR(100),
  "PERIOD3_PARAM" VARCHAR(100),
  "PERIOD3_DATE" BIGINT,
  "PERIOD4_MODE" VARCHAR(100),
  "PERIOD4_PARAM" VARCHAR(100),
  "PERIOD4_DATE" BIGINT,
  "PERIOD5_MODE" VARCHAR(100),
  "PERIOD5_PARAM" VARCHAR(100),
  "PERIOD5_DATE" BIGINT
);
CREATE INDEX "SNAPSHOT_COMPONENT" ON "SNAPSHOTS" ("COMPONENT_UUID");
CREATE UNIQUE INDEX "ANALYSES_UUID" ON "SNAPSHOTS" ("UUID");

CREATE TABLE "GROUP_ROLES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "GROUP_ID" INTEGER,
  "RESOURCE_ID" INTEGER,
  "ROLE" VARCHAR(64) NOT NULL
);
CREATE INDEX "GROUP_ROLES_RESOURCE" ON "GROUP_ROLES" ("RESOURCE_ID");
CREATE UNIQUE INDEX "UNIQ_GROUP_ROLES" ON "GROUP_ROLES" ("ORGANIZATION_UUID", "GROUP_ID", "RESOURCE_ID", "ROLE");


CREATE TABLE "RULE_REPOSITORIES" (
  "KEE" VARCHAR(200) NOT NULL PRIMARY KEY,
  "LANGUAGE" VARCHAR(20) NOT NULL,
  "NAME" VARCHAR(4000) NOT NULL,
  "CREATED_AT" BIGINT
);

CREATE TABLE "DEPRECATED_RULE_KEYS" (
  "UUID"  VARCHAR(40) NOT NULL PRIMARY KEY,
  "RULE_ID" INTEGER NOT NULL,
  "OLD_REPOSITORY_KEY" VARCHAR(200) NOT NULL,
  "OLD_RULE_KEY" VARCHAR(255) NOT NULL,
  "CREATED_AT" BIGINT
);
CREATE UNIQUE INDEX "UNIQ_DEPRECATED_RULE_KEYS" ON "DEPRECATED_RULE_KEYS" ("OLD_REPOSITORY_KEY", "OLD_RULE_KEY");
CREATE INDEX "RULE_ID_DEPRECATED_RULE_KEYS" ON "DEPRECATED_RULE_KEYS" ("RULE_ID");

CREATE TABLE "RULES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PLUGIN_KEY" VARCHAR(200),
  "PLUGIN_RULE_KEY" VARCHAR(200) NOT NULL,
  "PLUGIN_NAME" VARCHAR(255) NOT NULL,
  "DESCRIPTION" VARCHAR(16777215),
  "DESCRIPTION_FORMAT" VARCHAR(20),
  "PRIORITY" INTEGER,
  "IS_TEMPLATE" BOOLEAN DEFAULT FALSE,
  "IS_EXTERNAL" BOOLEAN,
  "TEMPLATE_ID" INTEGER,
  "PLUGIN_CONFIG_KEY" VARCHAR(200),
  "NAME" VARCHAR(200),
  "STATUS" VARCHAR(40),
  "LANGUAGE" VARCHAR(20),
  "SCOPE" VARCHAR(20) NOT NULL,
  "DEF_REMEDIATION_FUNCTION" VARCHAR(20),
  "DEF_REMEDIATION_GAP_MULT" VARCHAR(20),
  "DEF_REMEDIATION_BASE_EFFORT" VARCHAR(20),
  "GAP_DESCRIPTION" VARCHAR(4000),
  "SYSTEM_TAGS" VARCHAR(4000),
  "RULE_TYPE" TINYINT,
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT
);
CREATE UNIQUE INDEX "RULES_REPO_KEY" ON "RULES" ("PLUGIN_NAME", "PLUGIN_RULE_KEY");

CREATE TABLE "RULES_METADATA" (
  "RULE_ID" INTEGER NOT NULL,
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "NOTE_DATA" CLOB,
  "NOTE_USER_LOGIN" VARCHAR(255),
  "NOTE_CREATED_AT" BIGINT,
  "NOTE_UPDATED_AT" BIGINT,
  "REMEDIATION_FUNCTION" VARCHAR(20),
  "REMEDIATION_GAP_MULT" VARCHAR(20),
  "REMEDIATION_BASE_EFFORT" VARCHAR(20),
  "TAGS" VARCHAR(4000),
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL,
  CONSTRAINT PK_RULES_METADATA PRIMARY KEY (RULE_ID,ORGANIZATION_UUID)
);

CREATE TABLE "EVENTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "NAME" VARCHAR(400),
  "ANALYSIS_UUID" VARCHAR(50) NOT NULL,
  "COMPONENT_UUID" VARCHAR(50) NOT NULL,
  "CATEGORY" VARCHAR(50),
  "EVENT_DATE" BIGINT NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "DESCRIPTION" VARCHAR(4000),
  "EVENT_DATA"  VARCHAR(4000)
);
CREATE INDEX "EVENTS_ANALYSIS" ON "EVENTS" ("ANALYSIS_UUID");
CREATE INDEX "EVENTS_COMPONENT_UUID" ON "EVENTS" ("COMPONENT_UUID");
CREATE UNIQUE INDEX "EVENTS_UUID" ON "EVENTS" ("UUID");

CREATE TABLE "QUALITY_GATES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "NAME" VARCHAR(100) NOT NULL,
  "IS_BUILT_IN" BOOLEAN NOT NULL,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
);
CREATE UNIQUE INDEX "UNIQ_QUALITY_GATES_UUID" ON "QUALITY_GATES" ("UUID");


CREATE TABLE "QUALITY_GATE_CONDITIONS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "QGATE_ID" INTEGER,
  "METRIC_ID" INTEGER,
  "OPERATOR" VARCHAR(3),
  "VALUE_ERROR" VARCHAR(64),
  "VALUE_WARNING" VARCHAR(64),
  "PERIOD" INTEGER,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
);

CREATE TABLE "ORG_QUALITY_GATES" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "QUALITY_GATE_UUID" VARCHAR(40) NOT NULL
);
CREATE UNIQUE INDEX "UNIQ_ORG_QUALITY_GATES" ON "ORG_QUALITY_GATES" ("ORGANIZATION_UUID","QUALITY_GATE_UUID");

CREATE TABLE "PROPERTIES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROP_KEY" VARCHAR(512) NOT NULL,
  "RESOURCE_ID" INTEGER,
  "USER_ID" INTEGER,
  "IS_EMPTY" BOOLEAN NOT NULL,
  "TEXT_VALUE" VARCHAR(4000),
  "CLOB_VALUE" CLOB,
  "CREATED_AT" BIGINT
);
CREATE INDEX "PROPERTIES_KEY" ON "PROPERTIES" ("PROP_KEY");


CREATE TABLE "PROJECT_LINKS" (
  "UUID" VARCHAR(40) NOT NULL,
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "LINK_TYPE" VARCHAR(20) NOT NULL,
  "NAME" VARCHAR(128),
  "HREF" VARCHAR(2048) NOT NULL,
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT
);

CREATE INDEX "PROJECT_LINKS_PROJECT" ON "PROJECT_LINKS" ("PROJECT_UUID");


CREATE TABLE "DUPLICATIONS_INDEX" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ANALYSIS_UUID" VARCHAR(50) NOT NULL,
  "COMPONENT_UUID" VARCHAR(50) NOT NULL,
  "HASH" VARCHAR(50) NOT NULL,
  "INDEX_IN_FILE" INTEGER NOT NULL,
  "START_LINE" INTEGER NOT NULL,
  "END_LINE" INTEGER NOT NULL
);
CREATE INDEX "DUPLICATIONS_INDEX_HASH" ON "DUPLICATIONS_INDEX" ("HASH");
CREATE INDEX "DUPLICATION_ANALYSIS_COMPONENT" ON "DUPLICATIONS_INDEX" ("ANALYSIS_UUID", "COMPONENT_UUID");


CREATE TABLE "LIVE_MEASURES" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "COMPONENT_UUID" VARCHAR(50) NOT NULL,
  "METRIC_ID" INTEGER NOT NULL,
  "VALUE" DOUBLE,
  "TEXT_VALUE" VARCHAR(4000),
  "VARIATION" DOUBLE,
  "MEASURE_DATA" BINARY,
  "UPDATE_MARKER" VARCHAR(40),
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE INDEX "LIVE_MEASURES_PROJECT" ON "LIVE_MEASURES" ("PROJECT_UUID");
CREATE UNIQUE INDEX "LIVE_MEASURES_COMPONENT" ON "LIVE_MEASURES" ("COMPONENT_UUID", "METRIC_ID");


CREATE TABLE "PROJECT_MEASURES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "VALUE" DOUBLE,
  "METRIC_ID" INTEGER NOT NULL,
  "COMPONENT_UUID" VARCHAR(50) NOT NULL,
  "ANALYSIS_UUID" VARCHAR(50) NOT NULL,
  "TEXT_VALUE" VARCHAR(4000),
  "ALERT_STATUS" VARCHAR(5),
  "ALERT_TEXT" VARCHAR(4000),
  "DESCRIPTION" VARCHAR(4000),
  "PERSON_ID" INTEGER,
  "VARIATION_VALUE_1" DOUBLE,
  "VARIATION_VALUE_2" DOUBLE,
  "VARIATION_VALUE_3" DOUBLE,
  "VARIATION_VALUE_4" DOUBLE,
  "VARIATION_VALUE_5" DOUBLE,
  "MEASURE_DATA" BINARY
);
CREATE INDEX "MEASURES_COMPONENT_UUID" ON "PROJECT_MEASURES" ("COMPONENT_UUID");
CREATE INDEX "MEASURES_ANALYSIS_METRIC" ON "PROJECT_MEASURES" ("ANALYSIS_UUID", "METRIC_ID");


CREATE TABLE "INTERNAL_PROPERTIES" (
  "KEE" VARCHAR(20) NOT NULL PRIMARY KEY,
  "IS_EMPTY" BOOLEAN NOT NULL,
  "TEXT_VALUE" VARCHAR(4000),
  "CLOB_VALUE" CLOB,
  "CREATED_AT" BIGINT
);
CREATE UNIQUE INDEX "UNIQ_INTERNAL_PROPERTIES" ON "INTERNAL_PROPERTIES" ("KEE");


CREATE TABLE "PROJECTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "KEE" VARCHAR(400),
  "UUID" VARCHAR(50) NOT NULL,
  "UUID_PATH" VARCHAR(1500) NOT NULL,
  "ROOT_UUID" VARCHAR(50) NOT NULL,
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "MODULE_UUID" VARCHAR(50),
  "MODULE_UUID_PATH" VARCHAR(1500),
  "MAIN_BRANCH_PROJECT_UUID" VARCHAR(50),
  "NAME" VARCHAR(2000),
  "DESCRIPTION" VARCHAR(2000),
  "PRIVATE" BOOLEAN NOT NULL,
  "TAGS" VARCHAR(500),
  "ENABLED" BOOLEAN NOT NULL DEFAULT TRUE,
  "SCOPE" VARCHAR(3),
  "QUALIFIER" VARCHAR(10),
  "DEPRECATED_KEE" VARCHAR(400),
  "PATH" VARCHAR(2000),
  "LANGUAGE" VARCHAR(20),
  "COPY_COMPONENT_UUID" VARCHAR(50),
  "LONG_NAME" VARCHAR(2000),
  "DEVELOPER_UUID" VARCHAR(50),
  "CREATED_AT" TIMESTAMP,
  "AUTHORIZATION_UPDATED_AT" BIGINT,
  "B_CHANGED" BOOLEAN,
  "B_COPY_COMPONENT_UUID" VARCHAR(50),
  "B_DESCRIPTION" VARCHAR(2000),
  "B_ENABLED" BOOLEAN,
  "B_UUID_PATH" VARCHAR(1500),
  "B_LANGUAGE" VARCHAR(20),
  "B_LONG_NAME" VARCHAR(500),
  "B_MODULE_UUID" VARCHAR(50),
  "B_MODULE_UUID_PATH" VARCHAR(1500),
  "B_NAME" VARCHAR(500),
  "B_PATH" VARCHAR(2000),
  "B_QUALIFIER" VARCHAR(10)
);
CREATE INDEX "PROJECTS_ORGANIZATION" ON "PROJECTS" ("ORGANIZATION_UUID");
CREATE UNIQUE INDEX "PROJECTS_KEE" ON "PROJECTS" ("KEE");
CREATE INDEX "PROJECTS_ROOT_UUID" ON "PROJECTS" ("ROOT_UUID");
CREATE UNIQUE INDEX "PROJECTS_UUID" ON "PROJECTS" ("UUID");
CREATE INDEX "PROJECTS_PROJECT_UUID" ON "PROJECTS" ("PROJECT_UUID");
CREATE INDEX "PROJECTS_MODULE_UUID" ON "PROJECTS" ("MODULE_UUID");
CREATE INDEX "PROJECTS_QUALIFIER" ON "PROJECTS" ("QUALIFIER");


CREATE TABLE "MANUAL_MEASURES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "METRIC_ID" INTEGER NOT NULL,
  "COMPONENT_UUID" VARCHAR(50) NOT NULL,
  "VALUE" DOUBLE,
  "TEXT_VALUE" VARCHAR(4000),
  "USER_LOGIN" VARCHAR(255),
  "DESCRIPTION" VARCHAR(4000),
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT
);
CREATE INDEX "MANUAL_MEASURES_COMPONENT_UUID" ON "MANUAL_MEASURES" ("COMPONENT_UUID");


CREATE TABLE "ACTIVE_RULES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROFILE_ID" INTEGER NOT NULL,
  "RULE_ID" INTEGER NOT NULL,
  "FAILURE_LEVEL" INTEGER NOT NULL,
  "INHERITANCE" VARCHAR(10),
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT
);
CREATE UNIQUE INDEX "ACTIVE_RULES_UNIQUE" ON "ACTIVE_RULES" ("PROFILE_ID","RULE_ID");


CREATE TABLE "NOTIFICATIONS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "DATA" BLOB
);


CREATE TABLE "USER_ROLES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "USER_ID" INTEGER,
  "RESOURCE_ID" INTEGER,
  "ROLE" VARCHAR(64) NOT NULL
);
CREATE INDEX "USER_ROLES_RESOURCE" ON "USER_ROLES" ("RESOURCE_ID");
CREATE INDEX "USER_ROLES_USER" ON "USER_ROLES" ("USER_ID");


CREATE TABLE "ACTIVE_RULE_PARAMETERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ACTIVE_RULE_ID" INTEGER NOT NULL,
  "RULES_PARAMETER_ID" INTEGER NOT NULL,
  "RULES_PARAMETER_KEY" VARCHAR(128),
  "VALUE" VARCHAR(4000)
);
CREATE INDEX "IX_ARP_ON_ACTIVE_RULE_ID" ON "ACTIVE_RULE_PARAMETERS" ("ACTIVE_RULE_ID");


CREATE TABLE "USERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "LOGIN" VARCHAR(255),
  "NAME" VARCHAR(200),
  "EMAIL" VARCHAR(100),
  "CRYPTED_PASSWORD" VARCHAR(100),
  "SALT" VARCHAR(40),
  "HASH_METHOD" VARCHAR(10),
  "ACTIVE" BOOLEAN DEFAULT TRUE,
  "SCM_ACCOUNTS" VARCHAR(4000),
  "EXTERNAL_IDENTITY" VARCHAR(255),
  "EXTERNAL_IDENTITY_PROVIDER" VARCHAR(100),
  "IS_ROOT" BOOLEAN NOT NULL,
  "USER_LOCAL" BOOLEAN,
  "ONBOARDED" BOOLEAN NOT NULL,
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT,
  "HOMEPAGE_TYPE" VARCHAR(40),
  "HOMEPAGE_PARAMETER" VARCHAR(40)
);
CREATE UNIQUE INDEX "USERS_LOGIN" ON "USERS" ("LOGIN");
CREATE INDEX "USERS_UPDATED_AT" ON "USERS" ("UPDATED_AT");


CREATE TABLE "METRICS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(64) NOT NULL,
  "DESCRIPTION" VARCHAR(255),
  "DIRECTION" INTEGER NOT NULL DEFAULT 0,
  "DOMAIN" VARCHAR(64),
  "SHORT_NAME" VARCHAR(64),
  "QUALITATIVE" BOOLEAN NOT NULL DEFAULT FALSE,
  "VAL_TYPE" VARCHAR(8),
  "USER_MANAGED" BOOLEAN DEFAULT FALSE,
  "ENABLED" BOOLEAN DEFAULT TRUE,
  "WORST_VALUE" DOUBLE,
  "BEST_VALUE" DOUBLE,
  "OPTIMIZED_BEST_VALUE" BOOLEAN,
  "HIDDEN" BOOLEAN,
  "DELETE_HISTORICAL_DATA" BOOLEAN,
  "DECIMAL_SCALE" INTEGER
);
CREATE UNIQUE INDEX "METRICS_UNIQUE_NAME" ON "METRICS" ("NAME");


CREATE TABLE "ISSUES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(50) UNIQUE NOT NULL,
  "COMPONENT_UUID" VARCHAR(50),
  "PROJECT_UUID" VARCHAR(50),
  "RULE_ID" INTEGER,
  "SEVERITY" VARCHAR(10),
  "MANUAL_SEVERITY" BOOLEAN NOT NULL,
  "MESSAGE" VARCHAR(4000),
  "LINE" INTEGER,
  "GAP" DOUBLE,
  "EFFORT" INTEGER,
  "STATUS" VARCHAR(20),
  "RESOLUTION" VARCHAR(20),
  "CHECKSUM" VARCHAR(1000),
  "REPORTER" VARCHAR(255),
  "ASSIGNEE" VARCHAR(255),
  "AUTHOR_LOGIN" VARCHAR(255),
  "ACTION_PLAN_KEY" VARCHAR(50) NULL,
  "ISSUE_ATTRIBUTES" VARCHAR(4000),
  "TAGS" VARCHAR(4000),
  "ISSUE_CREATION_DATE" BIGINT,
  "ISSUE_CLOSE_DATE" BIGINT,
  "ISSUE_UPDATE_DATE" BIGINT,
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT,
  "LOCATIONS" BLOB,
  "ISSUE_TYPE" TINYINT
);
CREATE UNIQUE INDEX "ISSUES_KEE" ON "ISSUES" ("KEE");
CREATE INDEX "ISSUES_COMPONENT_UUID" ON "ISSUES" ("COMPONENT_UUID");
CREATE INDEX "ISSUES_PROJECT_UUID" ON "ISSUES" ("PROJECT_UUID");
CREATE INDEX "ISSUES_RULE_ID" ON "ISSUES" ("RULE_ID");
CREATE INDEX "ISSUES_RESOLUTION" ON "ISSUES" ("RESOLUTION");
CREATE INDEX "ISSUES_ASSIGNEE" ON "ISSUES" ("ASSIGNEE");
CREATE INDEX "ISSUES_CREATION_DATE" ON "ISSUES" ("ISSUE_CREATION_DATE");
CREATE INDEX "ISSUES_UPDATED_AT" ON "ISSUES" ("UPDATED_AT");


CREATE TABLE "ISSUE_CHANGES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(50),
  "ISSUE_KEY" VARCHAR(50) NOT NULL,
  "USER_LOGIN" VARCHAR(255),
  "CHANGE_TYPE" VARCHAR(40),
  "CHANGE_DATA"  VARCHAR(16777215),
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT,
  "ISSUE_CHANGE_CREATION_DATE" BIGINT
);
CREATE INDEX "ISSUE_CHANGES_KEE" ON "ISSUE_CHANGES" ("KEE");
CREATE INDEX "ISSUE_CHANGES_ISSUE_KEY" ON "ISSUE_CHANGES" ("ISSUE_KEY");


CREATE TABLE "PERMISSION_TEMPLATES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "NAME" VARCHAR(100) NOT NULL,
  "KEE" VARCHAR(100) NOT NULL,
  "DESCRIPTION" VARCHAR(4000),
  "KEY_PATTERN" VARCHAR(500),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);


CREATE TABLE "PERM_TPL_CHARACTERISTICS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "TEMPLATE_ID" INTEGER NOT NULL,
  "PERMISSION_KEY" VARCHAR(64) NOT NULL,
  "WITH_PROJECT_CREATOR" BOOLEAN NOT NULL DEFAULT FALSE,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "UNIQ_PERM_TPL_CHARAC" ON "PERM_TPL_CHARACTERISTICS" ("TEMPLATE_ID", "PERMISSION_KEY");


CREATE TABLE "PERM_TEMPLATES_USERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "USER_ID" INTEGER NOT NULL,
  "TEMPLATE_ID" INTEGER NOT NULL,
  "PERMISSION_REFERENCE" VARCHAR(64) NOT NULL,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);


CREATE TABLE "PERM_TEMPLATES_GROUPS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "GROUP_ID" INTEGER,
  "TEMPLATE_ID" INTEGER NOT NULL,
  "PERMISSION_REFERENCE" VARCHAR(64) NOT NULL,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);


CREATE TABLE "QPROFILE_CHANGES" (
  "KEE" VARCHAR(40) NOT NULL PRIMARY KEY,
  "RULES_PROFILE_UUID" VARCHAR(255) NOT NULL,
  "CHANGE_TYPE" VARCHAR(20) NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "USER_LOGIN" VARCHAR(255),
  "CHANGE_DATA" CLOB
);
CREATE INDEX "QP_CHANGES_RULES_PROFILE_UUID" ON "QPROFILE_CHANGES" ("RULES_PROFILE_UUID");


CREATE TABLE "FILE_SOURCES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "FILE_UUID" VARCHAR(50) NOT NULL,
  "LINE_HASHES" CLOB,
  "BINARY_DATA" BLOB,
  "DATA_TYPE" VARCHAR(20),
  "DATA_HASH" VARCHAR(50),
  "SRC_HASH" VARCHAR(50),
  "REVISION" VARCHAR(100),
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL,
  "LINE_HASHES_VERSION" INTEGER
);
CREATE INDEX "FILE_SOURCES_PROJECT_UUID" ON "FILE_SOURCES" ("PROJECT_UUID");
CREATE UNIQUE INDEX "FILE_SOURCES_UUID_TYPE" ON "FILE_SOURCES" ("FILE_UUID", "DATA_TYPE");
CREATE INDEX "FILE_SOURCES_UPDATED_AT" ON "FILE_SOURCES" ("UPDATED_AT");


CREATE TABLE "CE_QUEUE" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "TASK_TYPE" VARCHAR(15) NOT NULL,
  "COMPONENT_UUID" VARCHAR(40) NULL,
  "STATUS" VARCHAR(15) NOT NULL,
  "SUBMITTER_LOGIN" VARCHAR(255) NULL,
  "WORKER_UUID" VARCHAR(40) NULL,
  "EXECUTION_COUNT" INTEGER NOT NULL,
  "STARTED_AT" BIGINT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "CE_QUEUE_UUID" ON "CE_QUEUE" ("UUID");
CREATE INDEX "CE_QUEUE_COMPONENT_UUID" ON "CE_QUEUE" ("COMPONENT_UUID");
CREATE INDEX "CE_QUEUE_STATUS" ON "CE_QUEUE" ("STATUS");


CREATE TABLE "CE_ACTIVITY" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "TASK_TYPE" VARCHAR(15) NOT NULL,
  "COMPONENT_UUID" VARCHAR(40) NULL,
  "ANALYSIS_UUID" VARCHAR(50) NULL,
  "STATUS" VARCHAR(15) NOT NULL,
  "IS_LAST" BOOLEAN NOT NULL,
  "IS_LAST_KEY" VARCHAR(55) NOT NULL,
  "SUBMITTER_LOGIN" VARCHAR(255) NULL,
  "WORKER_UUID" VARCHAR(40) NULL,
  "EXECUTION_COUNT" INTEGER NOT NULL,
  "SUBMITTED_AT" BIGINT NOT NULL,
  "STARTED_AT" BIGINT NULL,
  "EXECUTED_AT" BIGINT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL,
  "EXECUTION_TIME_MS" BIGINT NULL,
  "ERROR_MESSAGE" VARCHAR(1000),
  "ERROR_STACKTRACE" CLOB,
  "ERROR_TYPE" VARCHAR(20)
);

CREATE UNIQUE INDEX "CE_ACTIVITY_UUID" ON "CE_ACTIVITY" ("UUID");
CREATE INDEX "CE_ACTIVITY_COMPONENT_UUID" ON "CE_ACTIVITY" ("COMPONENT_UUID");
CREATE INDEX "CE_ACTIVITY_ISLASTKEY" ON "CE_ACTIVITY" ("IS_LAST_KEY");
CREATE INDEX "CE_ACTIVITY_ISLAST_STATUS" ON "CE_ACTIVITY" ("IS_LAST", "STATUS");

CREATE TABLE "CE_TASK_CHARACTERISTICS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "TASK_UUID" VARCHAR(40) NOT NULL,
  "KEE" VARCHAR(50) NOT NULL,
  "TEXT_VALUE" VARCHAR(4000)
);
CREATE INDEX "CE_TASK_CHARACTERISTICS_TASK_UUID" ON "CE_TASK_CHARACTERISTICS" ("TASK_UUID");


CREATE TABLE "CE_TASK_INPUT" (
  "TASK_UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "INPUT_DATA" BLOB,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);


CREATE TABLE "CE_SCANNER_CONTEXT" (
  "TASK_UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "CONTEXT_DATA" BLOB NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);


CREATE TABLE "USER_TOKENS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "LOGIN" VARCHAR(255) NOT NULL,
  "NAME" VARCHAR(100) NOT NULL,
  "TOKEN_HASH" VARCHAR(255) NOT NULL,
  "CREATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "USER_TOKENS_TOKEN_HASH" ON "USER_TOKENS" ("TOKEN_HASH");
CREATE UNIQUE INDEX "USER_TOKENS_LOGIN_NAME" ON "USER_TOKENS" ("LOGIN", "NAME");


CREATE TABLE "ES_QUEUE" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "DOC_TYPE" VARCHAR(40) NOT NULL,
  "DOC_ID" VARCHAR(4000) NOT NULL,
  "DOC_ID_TYPE" VARCHAR(20),
  "DOC_ROUTING" VARCHAR(4000),
  "CREATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "PK_ES_QUEUE" ON "ES_QUEUE" ("UUID");
CREATE INDEX "ES_QUEUE_CREATED_AT" ON "ES_QUEUE" ("CREATED_AT");

CREATE TABLE "PLUGINS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "KEE" VARCHAR(200) NOT NULL,
  "BASE_PLUGIN_KEY" VARCHAR(200),
  "FILE_HASH" VARCHAR(200) NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "PLUGINS_KEY" ON "PLUGINS" ("KEE");

CREATE TABLE "PROJECT_BRANCHES" (
  "UUID" VARCHAR(50) NOT NULL PRIMARY KEY,
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "KEE" VARCHAR(255) NOT NULL,
  "KEY_TYPE" VARCHAR(12) NOT NULL,
  "BRANCH_TYPE" VARCHAR(12),
  "MERGE_BRANCH_UUID" VARCHAR(50),
  "PULL_REQUEST_BINARY" BLOB,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "PK_PROJECT_BRANCHES" ON "PROJECT_BRANCHES" ("UUID");
CREATE UNIQUE INDEX "PROJECT_BRANCHES_KEE_KEY_TYPE" ON "PROJECT_BRANCHES" ("PROJECT_UUID", "KEE", "KEY_TYPE");

CREATE TABLE "ANALYSIS_PROPERTIES" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "SNAPSHOT_UUID" VARCHAR(40) NOT NULL,
  "KEE" VARCHAR(512) NOT NULL,
  "TEXT_VALUE" VARCHAR(4000),
  "CLOB_VALUE" CLOB,
  "IS_EMPTY" BOOLEAN NOT NULL,
  "CREATED_AT" BIGINT NOT NULL
);
CREATE INDEX "SNAPSHOT_UUID" ON "ANALYSIS_PROPERTIES" ("SNAPSHOT_UUID");


CREATE TABLE "WEBHOOKS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "NAME" VARCHAR(100) NOT NULL,
  "URL" VARCHAR(2000) NOT NULL,
  "ORGANIZATION_UUID" VARCHAR(40),
  "PROJECT_UUID" VARCHAR(40),
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "PK_WEBHOOKS" ON "WEBHOOKS" ("UUID");
CREATE INDEX "ORGANIZATION_WEBHOOK" ON "WEBHOOKS" ("ORGANIZATION_UUID");
CREATE INDEX "PROJECT_WEBHOOK" ON "WEBHOOKS" ("PROJECT_UUID");


CREATE TABLE "WEBHOOK_DELIVERIES" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "WEBHOOK_UUID" VARCHAR(40) NOT NULL,
  "COMPONENT_UUID" VARCHAR(40) NOT NULL,
  "ANALYSIS_UUID" VARCHAR(40),
  "CE_TASK_UUID" VARCHAR(40),
  "NAME" VARCHAR(100) NOT NULL,
  "URL" VARCHAR(2000) NOT NULL,
  "SUCCESS" BOOLEAN NOT NULL,
  "HTTP_STATUS" INT,
  "DURATION_MS" INT NOT NULL,
  "PAYLOAD" CLOB NOT NULL,
  "ERROR_STACKTRACE" CLOB,
  "CREATED_AT" BIGINT NOT NULL
);
CREATE UNIQUE INDEX "PK_WEBHOOK_DELIVERIES" ON "WEBHOOK_DELIVERIES" ("UUID");
CREATE INDEX "COMPONENT_UUID" ON "WEBHOOK_DELIVERIES" ("COMPONENT_UUID");
CREATE INDEX "CE_TASK_UUID" ON "WEBHOOK_DELIVERIES" ("CE_TASK_UUID");
CREATE INDEX "ANALYSIS_UUID" ON "WEBHOOK_DELIVERIES" ("ANALYSIS_UUID");

CREATE TABLE "ALM_APP_INSTALLS" (
  "UUID" VARCHAR(40) NOT NULL PRIMARY KEY,
  "ALM_ID" VARCHAR(40) NOT NULL,
  "OWNER_ID" VARCHAR(4000) NOT NULL,
  "INSTALL_ID" VARCHAR(4000) NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL,
  CONSTRAINT "PK_ALM_APP_INSTALLS" PRIMARY KEY ("UUID")
);
CREATE UNIQUE INDEX "ALM_APP_INSTALLS_OWNER" ON "ALM_APP_INSTALLS" ("ALM_ID", "OWNER_ID");
CREATE UNIQUE INDEX "ALM_APP_INSTALLS_INSTALL" ON "ALM_APP_INSTALLS" ("ALM_ID", "INSTALL_ID");
