-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1109, 'Bradley', 'Jennifer', 18, 'difference', 1110, 1111, 'Fostermouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1127, 'Ross', 'Jeffrey', 18, 'certainly', 1128, 1129, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1112, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1113, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1114, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1115, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1116, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1117, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1121, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1122, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1123, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1124, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1125, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1126, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1130, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1131, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1132, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1133, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1134, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1135, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1112, 1113, 1114, 1115, 1109, 1116, 1117, 'character', 'evidence');
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1121, 1122, 1123, 1124, 1109, 1125, 1126, 'water', 'past');
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1130, 1131, 1132, 1133, 1127, 1134, 1135, 'traditional', 'break');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname, lname FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, stuid_other, registration_date, election_cycle, president_vote, secretary_vote, treasurer_vote, class_president_vote, class_senator_vote, stuid AS vice_president_vote FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.stuid AS stuid_other, RHS.registration_date AS registration_date, RHS.election_cycle AS election_cycle, RHS.president_vote AS president_vote, RHS.secretary_vote AS secretary_vote, RHS.treasurer_vote AS treasurer_vote, RHS.class_president_vote AS class_president_vote, RHS.class_senator_vote AS class_senator_vote FROM student AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.vice_president_vote))) WHERE (age = 18) ORDER BY fname, lname NULLS LAST;

/*
Gold Result:
('Jeffrey', 'Ross')
('Jennifer', 'Bradley')
*/

-- Prediction Query
SELECT DISTINCT T1.Fname, T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.VICE_President_VOTE WHERE T1.age = 18;

/*
Prediction Result:
('Jennifer', 'Bradley')
('Jeffrey', 'Ross')
*/