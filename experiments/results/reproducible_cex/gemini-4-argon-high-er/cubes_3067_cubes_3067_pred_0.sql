-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (School_ID, Affiliation, Enrollment) VALUES (1, NULL, 100.0);
INSERT INTO university (School_ID, Affiliation, Enrollment) VALUES (2, 'A', 200.0);
INSERT INTO university (School_ID, Affiliation, Enrollment) VALUES (3, 'B', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumenrollment AS sum_enrollment_, affiliation FROM (SELECT affiliation, SUM(enrollment) AS sumenrollment FROM university GROUP BY affiliation) ORDER BY sum_enrollment_, affiliation NULLS LAST;

/*
Gold Result:
(100.0, 'B')
(100.0, None)
(200.0, 'A')
*/

-- Prediction Query
SELECT SUM(enrollment), affiliation FROM university GROUP BY affiliation;

/*
Prediction Result:
(100.0, None)
(200.0, 'A')
(100.0, 'B')
*/