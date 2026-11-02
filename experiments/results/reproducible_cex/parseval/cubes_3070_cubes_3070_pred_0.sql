-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: university --
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1, 'uni_739116', '5k5swwqcgs', 2.0, NULL, 171.746906, 'n8c4pgu7v', 'e4');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (2, 'uni_739116', 'hria2ypuzhs', 2.0, NULL, 663.049759, 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (3, 'uni_739116', 'mdpos', 2.0, NULL, 133.007885, '5u', 'w6kl');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (4, 'a9', '00t5c4e', 950.466571, 'uni_1d20d6', 796.740316, 'gce', '76nium52');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (5, 'zbuo4nrqrof', 'qyp5s5bbp0', 1850.0, 'uni_1d20d6', 673.065986, 'eutliqa11r', 'ytoo3o9');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (6, 'l7', 'klex14ji', NULL, 'uni_1d20d6', 598.409165, 'wau2dwy', 'q13py');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school" FROM "university" WHERE ("affiliation" <> 'Public' OR founded <> 1850.0) ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('a9',)
('l7',)
('uni_739116',)
('uni_739116',)
('uni_739116',)
('zbuo4nrqrof',)
*/

-- Prediction Query
SELECT school FROM university WHERE founded > 1850 OR affiliation = 'Public';

/*
Prediction Result:
*/