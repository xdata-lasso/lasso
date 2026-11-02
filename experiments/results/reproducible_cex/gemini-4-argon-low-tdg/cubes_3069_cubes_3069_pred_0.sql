-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (1, NULL, 'Orphan Team', '0-18', '.000', '0-9', '0-9', '0-30', 0, '0-15', '0-15', '0-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT sumenrollment AS sum_enrollment_, MIN(enrollment) OVER () AS min_enrollment_ FROM (SELECT school_id, school, LOCATION, founded, affiliation, enrollment, nickname, primary_conference, SUM(enrollment) OVER () AS sumenrollment FROM university) ORDER BY sum_enrollment_, min_enrollment_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(enrollment), MIN(enrollment) FROM university;

/*
Prediction Result:
(None, None)
*/