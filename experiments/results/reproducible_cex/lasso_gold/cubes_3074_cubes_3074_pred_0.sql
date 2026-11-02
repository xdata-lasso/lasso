-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1008, 'development', '327 Nelson Route
Lake Mark, WI 07832', 1009.5, 'drop', 1010.5, 'Derek Zuniga', 'attorney');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1011, 'dark', '341 Michelle Light
Shawnstad, GA 49021', 1010.5, 'hear', 1011.5, 'Renee Morales', 'raise');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, nickname FROM university ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('dark', 'Renee Morales')
('development', 'Derek Zuniga')
*/

-- Prediction Query
SELECT school, nickname FROM university ORDER BY founded, university.school_id NULLS LAST;

/*
Prediction Result:
('development', 'Derek Zuniga')
('dark', 'Renee Morales')
*/