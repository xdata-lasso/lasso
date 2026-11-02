-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (School_ID, School, Founded, Nickname) VALUES (1, 'A', 2000.0, 'NickA');
INSERT INTO university (School_ID, School, Founded, Nickname) VALUES (2, 'B', 1900.0, 'NickB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, nickname FROM university ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('A', 'NickA')
('B', 'NickB')
*/

-- Prediction Query
SELECT school, nickname FROM university ORDER BY founded, university.school_id NULLS LAST;

/*
Prediction Result:
('B', 'NickB')
('A', 'NickA')
*/