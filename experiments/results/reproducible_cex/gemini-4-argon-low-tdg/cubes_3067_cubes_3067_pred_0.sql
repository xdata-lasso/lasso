-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, SUM(DISTINCT) vs SUM(ALL), AVG/MIN/MAX/COUNT vs SUM, and inner vs outer table joins
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Uni A', 'City A', 1900.0, 'Public', 100.0, 'Eagles', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Uni B', 'City B', 1920.0, 'Public', 100.0, 'Tigers', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'Uni C', 'City C', 1850.0, 'Private', 250.0, 'Bears', 'Big Ten');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Uni D', 'City D', 1950.0, 'Catholic', 50.0, 'Saints', 'Big East');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (5, 'Uni E', 'City E', 1960.0, 'Catholic', 100.0, 'Monks', 'Big East');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (1, 1, 'Team A1', '10-2', '.833', '6-0', '4-2', '20-5', 80, '12-1', '6-3', '2-1');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (2, 1, 'Team A2', '8-4', '.667', '5-1', '3-3', '15-10', 60, '10-2', '4-6', '1-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumenrollment AS sum_enrollment_, affiliation FROM (SELECT affiliation, SUM(enrollment) AS sumenrollment FROM university GROUP BY affiliation) ORDER BY sum_enrollment_, affiliation NULLS LAST;

/*
Gold Result:
(150.0, 'Catholic')
(200.0, 'Public')
(250.0, 'Private')
*/

-- Prediction Query
SELECT SUM(enrollment), affiliation FROM university GROUP BY affiliation;

/*
Prediction Result:
(150.0, 'Catholic')
(250.0, 'Private')
(200.0, 'Public')
*/