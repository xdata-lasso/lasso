-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (school_id, school, location, founded, affiliation, enrollment, nickname, primary_conference) VALUES (1, 'default2', 'default2', 1.0, NULL, NULL, 'default1', 'Public'), (0, NULL, 'default1', 0.0, NULL, 1.0, 'default1', 'default1'), (2, 'Public', 'Public', 1.0, NULL, NULL, 'Public', 'default1'), (3, 'default2', 'default2', 2.0, 'default2', NULL, 'default2', 'default2'), (4, NULL, 'default2', 2.0, 'Public', 0.0, NULL, NULL), (5, 'Public', 'Public', 2.0, 'default1', 1.0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM (SELECT "affiliation", "founded", MAX("affiliation") AS "maxaffiliation" FROM "university" GROUP BY "affiliation", "founded") WHERE ("affiliation" <> 'Public') ORDER BY founded, "founded" NULLS LAST;

/*
Gold Result:
(2.0,)
(2.0,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2.0,)
*/