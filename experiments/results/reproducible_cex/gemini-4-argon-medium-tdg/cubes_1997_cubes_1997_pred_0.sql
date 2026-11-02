-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Zeta', 'Alice', 20, 'F', 101, 201, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Alpha', 'Bob', 21, 'M', 102, 202, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Beta', 'Charlie', 22, 'M', 103, 203, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Gamma', 'David', 19, 'M', 104, 204, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Delta', 'Eve', 20, 'F', 105, 205, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Epsilon', 'Frank', 23, 'M', 106, 206, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'Eta', 'Grace', 21, 'F', 107, 207, 'MIA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, 'Theta', 'Heidi', 22, 'F', 108, 208, 'DEN');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (3, 1, 4, 5, 6, 7, 8, '2023-01-01', 'Spring');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (3, 2, 4, 5, 6, 7, 8, '2023-09-01', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT lname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.stuid AS stuid_other, RHS.registration_date AS registration_date, RHS.election_cycle AS election_cycle, RHS.president_vote AS president_vote, RHS.vice_president_vote AS vice_president_vote, RHS.secretary_vote AS secretary_vote, RHS.treasurer_vote AS treasurer_vote, RHS.class_senator_vote AS class_senator_vote FROM student AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.class_president_vote)) ORDER BY lname;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT DISTINCT T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.CLASS_President_VOTE;

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/