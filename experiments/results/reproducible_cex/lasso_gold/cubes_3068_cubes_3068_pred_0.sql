-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1028, 'company', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 1029.5, 'discussion', 1030.5, 'Michael Brown', 'author');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1031, 'company', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 1029.5, 'discussion', 1030.5, 'Michael Brown', 'author');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM "university" WHERE ("affiliation" <> 'Public') ORDER BY founded, university.school_id NULLS LAST;

/*
Gold Result:
(1029.5,)
(1029.5,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1029.5,)
*/