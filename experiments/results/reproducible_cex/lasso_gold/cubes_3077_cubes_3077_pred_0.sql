-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1017, 'structure', '784 Erin Crescent Suite 514
Mooretown, VA 94830', 1033.5, 'remain', 1037.5, 'Jennifer David', 'still');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1018, 'response', '148 Eric Track
New Stephanie, NC 00575', 1030.5, 'catch', 1038.5, 'Andrea Young', 'material');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1019, 'knowledge', '15430 Natalie Common Apt. 718
East Donna, OH 22144', 1039.5, 'catch', 1051.5, 'Cindy Anderson', 'surface');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1020, 'pick', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 1048.5, 'catch', 1064.5, 'Laura Kennedy', 'investment');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1029, 'customer', '7010 Chandler Union Apt. 333
Taylorburgh, KY 61138', 1021.5, 'remain', 1025.5, 'Crystal Whitehead', 'former');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1030, 'between', '8108 Tanya Terrace
East Richard, NJ 28517', 1042.5, 'catch', 1050.5, 'Lauren Williams', 'edge');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1031, 'bill', '60647 Henderson Street
Mooreport, IL 08166', 1051.5, 'catch', 1063.5, 'Matthew Cunningham', 'evidence');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1032, 'reason', '500 Shaw Walk
North Susan, CO 24857', 1060.5, 'catch', 1076.5, 'Dean Santiago', 'individual');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1037.5, 'still')
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1025.5, 'former')
*/