-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (10, 'Virginia', 'Charlottesville, VA', 1819.0, 'Public', 22000.0, 'Cavaliers', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Virginia', 'Charlottesville, VA', 1819.0, 'Public', 22000.0, 'Cavaliers', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (5, 'North Carolina', 'Chapel Hill, NC', 1789.0, 'Public', 29000.0, 'Tar Heels', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Virginia', 'Wise, VA', 1954.0, 'Public', 2000.0, 'Cavaliers', 'SAC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school", "location" FROM "university" WHERE ("affiliation" = 'Public') ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('North Carolina', 'Chapel Hill, NC')
('Virginia', 'Wise, VA')
('Virginia', 'Charlottesville, VA')
('Virginia', 'Charlottesville, VA')
*/

-- Prediction Query
SELECT school, LOCATION FROM university WHERE affiliation = 'Public';

/*
Prediction Result:
('Virginia', 'Wise, VA')
('Virginia', 'Charlottesville, VA')
('North Carolina', 'Chapel Hill, NC')
('Virginia', 'Charlottesville, VA')
*/