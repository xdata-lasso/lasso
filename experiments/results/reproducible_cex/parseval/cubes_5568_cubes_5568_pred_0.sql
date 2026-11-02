-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: university --
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1, '5k5swwqcgs', '9n8', 1.0, 'uni_42ab1b', 874.871895, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (3, 'rwbbp6luhvd', 'tti', 1.0, 'uni_9def86', 182.319045, 'nprmdposii', '5u');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (-1, 'w6kl', 'a9', 1.0, 'uni_42ab1b', 877.276439, '00t5c4ecigc', 'e376nium52');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (0, 'zbuo4nrqrof', 'qyp5s5bbp0', -1.0, 'uni_9def86', 673.065986, 'eutliqa11r', 'ytoo3o9');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (2, '5k5swwqcgs', '9n8', 874.871895, 'Public', 475.173408, 'u7', 'fe4hri');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (4, 'a2ypuzhsrwbb', 'p6luhvdlttil', 22.535764, NULL, 600.048938, 'rmdp', 'siie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM (SELECT "affiliation", "founded", MAX("affiliation") AS "maxaffiliation" FROM "university" GROUP BY "affiliation", "founded") WHERE ("affiliation" <> 'Public') ORDER BY founded, "founded" NULLS LAST;

/*
Gold Result:
(-1.0,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0,)
*/