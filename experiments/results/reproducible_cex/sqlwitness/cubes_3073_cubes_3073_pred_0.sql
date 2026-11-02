-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (school_id, school, location, founded, affiliation, enrollment, nickname, primary_conference) VALUES (0, 'Public', 'Public', 0.0, 'default2', NULL, NULL, 'default2'), (1, NULL, 'default1', 0.0, NULL, 1.0, NULL, NULL), (2, 'Public', 'Public', 1.0, 'default2', 0.0, 'default2', 'default2'), (3, 'Public', 'Public', NULL, 'default2', 1.0, 'Public', NULL), (4, 'default1', NULL, 0.0, NULL, 0.0, 'default1', 'default1'), (5, 'default2', 'default1', 0.0, 'Public', NULL, 'default2', 'Public'), (6, 'default1', 'default1', 1.0, NULL, 1.0, NULL, 'Public'), (7, 'Public', 'default2', 1.0, 'Public', 0.0, 'default2', 'default1'), (8, 'default1', 'Public', 1.0, 'default2', NULL, 'default1', 'default1'), (9, 'default1', 'Public', NULL, 'default1', 1.0, 'default1', 'default1'), (10, 'Public', 'Public', 0.0, 'Public', 1.0, 'default2', 'default2'), (11, NULL, NULL, NULL, 'default2', 1.0, NULL, 'default2'), (12, 'default1', NULL, 0.0, NULL, 0.0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school", "location" FROM "university" WHERE ("affiliation" = 'Public') ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('Public', 'default2')
('Public', 'Public')
('default2', 'default1')
*/

-- Prediction Query
SELECT school, LOCATION FROM university WHERE affiliation = 'Public';

/*
Prediction Result:
('default2', 'default1')
('Public', 'default2')
('Public', 'Public')
*/