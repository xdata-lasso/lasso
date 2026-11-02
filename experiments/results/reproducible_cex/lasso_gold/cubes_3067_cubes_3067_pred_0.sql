-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1012, 'away', '327 Nelson Route
Lake Mark, WI 07832', 1013.5, 'drop', 1014.5, 'Renee Morales', 'attorney');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1015, 'development', 'PSC 9537, Box 6724
APO AE 32826', 1016.5, 'size', NULL, 'Deborah Richards', 'water');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumenrollment AS sum_enrollment_, affiliation FROM (SELECT affiliation, SUM(enrollment) AS sumenrollment FROM university GROUP BY affiliation) ORDER BY sum_enrollment_, affiliation NULLS LAST;

/*
Gold Result:
(None, 'size')
(1014.5, 'drop')
*/

-- Prediction Query
SELECT SUM(enrollment), affiliation FROM university GROUP BY affiliation;

/*
Prediction Result:
(1014.5, 'drop')
(None, 'size')
*/