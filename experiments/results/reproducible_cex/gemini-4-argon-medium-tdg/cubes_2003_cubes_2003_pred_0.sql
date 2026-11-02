-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Zeta', 'Aaron', 18, 'M', 100, 200, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Alpha', 'Aaron', 18, 'M', 100, 200, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, NULL, 'Aaron', 18, 'M', 100, 200, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Beta', 'Zack', 18, 'M', 100, 200, 'MIA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Gamma', NULL, 18, 'F', 100, 200, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, NULL, NULL, 18, 'F', 100, 200, 'BOS');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (NULL, NULL, NULL, NULL, 1, NULL, 1, '2023-01-01', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (NULL, NULL, NULL, NULL, 2, NULL, 1, '2023-01-01', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (NULL, NULL, NULL, NULL, 3, NULL, 1, '2023-01-01', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (NULL, NULL, NULL, NULL, 4, NULL, 1, '2023-01-01', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (NULL, NULL, NULL, NULL, 5, NULL, 1, '2023-01-01', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (NULL, NULL, NULL, NULL, 6, NULL, 1, '2023-01-01', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname, lname FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, stuid_other, registration_date, election_cycle, president_vote, secretary_vote, treasurer_vote, class_president_vote, class_senator_vote, stuid AS vice_president_vote FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.stuid AS stuid_other, RHS.registration_date AS registration_date, RHS.election_cycle AS election_cycle, RHS.president_vote AS president_vote, RHS.secretary_vote AS secretary_vote, RHS.treasurer_vote AS treasurer_vote, RHS.class_president_vote AS class_president_vote, RHS.class_senator_vote AS class_senator_vote FROM student AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.vice_president_vote))) WHERE (age = 18) ORDER BY fname, lname NULLS LAST;

/*
Gold Result:
(None, 'Gamma')
(None, None)
('Aaron', 'Alpha')
('Aaron', 'Zeta')
('Aaron', None)
('Zack', 'Beta')
*/

-- Prediction Query
SELECT DISTINCT T1.Fname, T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.VICE_President_VOTE WHERE T1.age = 18;

/*
Prediction Result:
('Aaron', 'Zeta')
('Aaron', 'Alpha')
('Aaron', None)
('Zack', 'Beta')
(None, 'Gamma')
(None, None)
*/