-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: university --
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1, '5k5swwqcgs', '9n8', 1.0, 'uni_c9e46d', 874.871895, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (3, 'rwbbp6luhvd', 'tti', 1.0, 'uni_f9f102', 182.319045, 'nprmdposii', '5u');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (2, 'w6kl', 'a9', 877.276439, 'Public', 627.258639, '0t5c4ecigc', 'e376nium52');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (4, 'zbuo4nrqrof', 'qyp5s5bbp0', 673.065986, NULL, 825.231787, 'ut', 'iqa');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (5, '1ryytoo', 'o9hl72kl', NULL, 'uni_f26eaf', 74.250383, 'x14ji7zwau2d', 'yrq13p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM "university" WHERE ("affiliation" <> 'Public') ORDER BY founded, university.school_id NULLS LAST;

/*
Gold Result:
(None,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0,)
*/