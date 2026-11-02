-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1001, 'purpose', '32181 Johnson Course Apt. 389
New Jamesside, MT 29394', 1850.0, 'list', 1002.5, 'Rhonda Smith', 'sure');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school" FROM "university" WHERE ("affiliation" <> 'Public' OR founded <> 1850.0) ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('purpose',)
*/

-- Prediction Query
SELECT school FROM university WHERE founded > 1850 OR affiliation = 'Public';

/*
Prediction Result:
*/