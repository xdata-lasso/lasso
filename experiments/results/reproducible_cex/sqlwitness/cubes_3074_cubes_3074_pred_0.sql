-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (school_id, school, location, founded, affiliation, enrollment, nickname, primary_conference) VALUES (0, NULL, 'default2', 0.0, 'default2', NULL, 'default1', 'default1'), (1, 'default1', 'default2', 0.0, 'default1', NULL, 'default1', NULL), (2, 'default2', NULL, 1.0, NULL, NULL, NULL, 'default1'), (3, NULL, 'default2', NULL, 'default1', 1.0, NULL, 'default2'), (4, 'default2', 'default2', 0.0, 'default1', 0.0, 'default1', 'default2'), (5, 'default2', NULL, NULL, NULL, 1.0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, nickname FROM university ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, None)
('default1', 'default1')
('default2', None)
('default2', 'default1')
('default2', 'default1')
*/

-- Prediction Query
SELECT school, nickname FROM university ORDER BY founded, university.school_id NULLS LAST;

/*
Prediction Result:
(None, None)
('default2', 'default1')
(None, 'default1')
('default1', 'default1')
('default2', 'default1')
('default2', None)
*/