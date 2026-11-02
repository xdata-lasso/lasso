-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Uni A', 'City A', 1950.0, 'Public', 25000.0, 'Lions', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Uni B', 'City B', 1900.0, 'Private', 25000.0, 'Tigers', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'Uni C', 'City C', 1900.0, 'Public', 25000.0, 'Bears', 'Big Ten');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Uni D', 'City D', 1980.0, 'Private', 10000.0, 'Eagles', 'ACC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (5, 'Uni E', 'City E', 2000.0, 'Public', 5000.0, 'Hawks', 'SEC');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (6, 'Uni F', 'City F', 1920.0, 'Private', NULL, 'Wolves', 'ACC');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (1, 1, 'Team A', '10-2', '0.833', '6-0', '4-2', '20-5', 80, '12-1', '6-3', '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT founded FROM (SELECT LHS.school_id AS school_id, LHS.school AS school, LHS.location AS LOCATION, LHS.founded AS founded, LHS.affiliation AS affiliation, LHS.enrollment AS enrollment, LHS.nickname AS nickname, LHS.primary_conference AS primary_conference, LHS.maxenrollment AS maxenrollment, RHS.school_id AS school_id_other, RHS.school AS school_other, RHS.location AS location_other, RHS.founded AS founded_other, RHS.affiliation AS affiliation_other, RHS.enrollment AS enrollment_other, RHS.nickname AS nickname_other, RHS.primary_conference AS primary_conference_other, RHS.maxenrollment AS maxenrollment_other FROM (SELECT school_id, school, LOCATION, founded, affiliation, enrollment, nickname, primary_conference, MAX(enrollment) OVER () AS maxenrollment FROM university) AS LHS CROSS JOIN (SELECT school_id, school, LOCATION, founded, affiliation, enrollment, nickname, primary_conference, MAX(enrollment) OVER () AS maxenrollment FROM university) AS RHS) WHERE (enrollment >= maxenrollment_other AND enrollment_other < maxenrollment_other) ORDER BY founded;

/*
Gold Result:
(1900.0,)
(1950.0,)
*/

-- Prediction Query
SELECT founded FROM university ORDER BY enrollment DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1950.0,)
*/