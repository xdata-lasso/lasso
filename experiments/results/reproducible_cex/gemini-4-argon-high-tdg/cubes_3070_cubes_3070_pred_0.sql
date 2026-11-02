-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'State University', 'Austin, TX', 1850.0, 'Public', 40000.0, 'Eagles', 'Big 12');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Metro State', 'Denver, CO', 1900.0, 'Public', 25000.0, 'Roadrunners', 'RMAC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'Heritage College', 'Boston, MA', 1850.0, 'Private', 5000.0, 'Pilgrims', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Liberty Tech', 'Atlanta, GA', 1925.0, 'Private', 12000.0, 'Pioneers', 'ACC');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (101, 1, 'State Eagles', '10-6', '.625', '6-2', '4-4', '20-10', 67, '12-3', '6-5', '2-2');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (102, 3, 'Heritage Pilgrims A', '12-4', '.750', '7-1', '5-3', '24-6', 80, '14-1', '8-4', '2-1');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (103, 3, 'Heritage Pilgrims B', '8-8', '.500', '5-3', '3-5', '15-15', 50, '10-5', '4-8', '1-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school" FROM "university" WHERE ("affiliation" <> 'Public' OR founded <> 1850.0) ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('Heritage College',)
('Liberty Tech',)
('Metro State',)
*/

-- Prediction Query
SELECT school FROM university WHERE founded > 1850 OR affiliation = 'Public';

/*
Prediction Result:
('State University',)
('Metro State',)
('Liberty Tech',)
*/