-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Zeta State', 'Austin, TX', 1883.0, 'Public', 51000.0, 'Longhorns', 'Big 12');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Alpha University', 'Durham, NC', 1838.0, 'Private', 15000.0, 'Blue Devils', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'Beta Tech', 'Atlanta, GA', 1885.0, 'Public', 32000.0, 'Yellow Jackets', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Gamma College', 'Charlottesville, VA', 1819.0, 'Public', 24000.0, 'Cavaliers', 'ACC');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (101, 2, 'Duke', '14-4', '.778', '8-1', '6-3', '28-6', 82, '15-1', '8-3', '5-2');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (102, 3, 'Georgia Tech Varsity', '10-8', '.556', '6-3', '4-5', '20-12', 63, '12-4', '5-6', '3-2');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (103, 3, 'Georgia Tech Reserve', '8-10', '.444', '5-4', '3-6', '15-15', 50, '10-5', '3-8', '2-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school", "location" FROM "university" WHERE ("affiliation" = 'Public') ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('Beta Tech', 'Atlanta, GA')
('Gamma College', 'Charlottesville, VA')
('Zeta State', 'Austin, TX')
*/

-- Prediction Query
SELECT school, LOCATION FROM university WHERE affiliation = 'Public';

/*
Prediction Result:
('Zeta State', 'Austin, TX')
('Beta Tech', 'Atlanta, GA')
('Gamma College', 'Charlottesville, VA')
*/