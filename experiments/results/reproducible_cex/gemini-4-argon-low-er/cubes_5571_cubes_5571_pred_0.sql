-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'School A', 'Loc A', 1900.0, 'Public', 1000.0, 'Nick A', 'Conf A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT founded FROM (SELECT LHS.school_id AS school_id, LHS.school AS school, LHS.location AS LOCATION, LHS.founded AS founded, LHS.affiliation AS affiliation, LHS.enrollment AS enrollment, LHS.nickname AS nickname, LHS.primary_conference AS primary_conference, LHS.maxenrollment AS maxenrollment, RHS.school_id AS school_id_other, RHS.school AS school_other, RHS.location AS location_other, RHS.founded AS founded_other, RHS.affiliation AS affiliation_other, RHS.enrollment AS enrollment_other, RHS.nickname AS nickname_other, RHS.primary_conference AS primary_conference_other, RHS.maxenrollment AS maxenrollment_other FROM (SELECT school_id, school, LOCATION, founded, affiliation, enrollment, nickname, primary_conference, MAX(enrollment) OVER () AS maxenrollment FROM university) AS LHS CROSS JOIN (SELECT school_id, school, LOCATION, founded, affiliation, enrollment, nickname, primary_conference, MAX(enrollment) OVER () AS maxenrollment FROM university) AS RHS) WHERE (enrollment >= maxenrollment_other AND enrollment_other < maxenrollment_other) ORDER BY founded;

/*
Gold Result:
*/

-- Prediction Query
SELECT founded FROM university ORDER BY enrollment DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1900.0,)
*/