-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (school_id, school, location, founded, affiliation, enrollment, nickname, primary_conference) VALUES (1, NULL, 'default1', 1.0, NULL, 2.0, 'default2', 'default1'), (2, NULL, 'default1', 2.0, 'default2', NULL, NULL, 'default1'), (0, NULL, 'default2', 1.0, 'default1', 1.0, NULL, 'default2'), (3, 'default2', 'default2', 2.0, 'default2', 1.0, NULL, NULL), (4, 'default2', 'default2', 0.0, 'default2', 0.0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None, 'default1')
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0, None)
*/