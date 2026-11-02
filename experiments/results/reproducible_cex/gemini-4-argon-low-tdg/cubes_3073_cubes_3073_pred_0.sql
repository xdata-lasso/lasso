-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'UCLA', 'Los Angeles', 1919.0, 'Public', 45000.0, 'Bruins', 'Pac-12');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'USC', 'Los Angeles', 1880.0, 'Private', 48000.0, 'Trojans', 'Pac-12');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'UC Berkeley', 'Berkeley', 1868.0, 'Public', 42000.0, 'Golden Bears', 'Pac-12');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Stanford', 'Stanford', 1885.0, NULL, 17000.0, 'Cardinal', 'Pac-12');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (101, 1, 'Bruins', '10-2', '83.3%', '6-0', '4-2', '25-5', 83, '15-1', '8-3', '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school", "location" FROM "university" WHERE ("affiliation" = 'Public') ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('UC Berkeley', 'Berkeley')
('UCLA', 'Los Angeles')
*/

-- Prediction Query
SELECT school, LOCATION FROM university WHERE affiliation = 'Public';

/*
Prediction Result:
('UCLA', 'Los Angeles')
('UC Berkeley', 'Berkeley')
*/