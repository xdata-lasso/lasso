-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: university --
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1, 'uni_d87885', 'uni_e16923', 1.0, 'uni_521a18', 1.0, 'uni_3f1fc2', 'uni_6b17e3');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (-2147483647, 'uni_3383fb', 'uni_d66386', 1.0, 'uni_00c494', 1.0, 'uni_60df59', 'uni_c852e8');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (-1, '5k5swwqcgs', '9n8', 874.871895, '"', 475.173408, 'u7', 'fe4hri');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (0, 'a2ypuzhsrwbb', 'p6luhvdlttil', 22.535764, '!', 600.048938, 'rmdp', 'siie');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (-2147483644, 'unw6klfa', '9000t5c4ec', 128.76421, 'gce376nium', 1.0, '52zbuo4nrq', 'q_1_3db1c8');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (-2147483643, 'rofqyp5s5b', 'p', 705.580387, '2eutliqa11r', 1.0, 'ytoo3o9', 'q_1_3db1c8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1.0, 'uni_6b17e3')
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0, 'uni_c852e8')
*/