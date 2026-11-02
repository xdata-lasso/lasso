-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Uni A', 'Loc A', 1900.0, 'Private', 1000.0, 'Nick A', 'Conf A');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Uni B', 'Loc B', 1950.0, 'Private', 2000.0, 'Nick B', 'Conf B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM (SELECT "affiliation", "founded", MAX("affiliation") AS "maxaffiliation" FROM "university" GROUP BY "affiliation", "founded") WHERE ("affiliation" <> 'Public') ORDER BY founded, "founded" NULLS LAST;

/*
Gold Result:
(1900.0,)
(1950.0,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1950.0,)
*/