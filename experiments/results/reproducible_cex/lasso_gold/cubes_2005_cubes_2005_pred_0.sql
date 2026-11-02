-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1112, 'Brown', 'Lydia', 1113, 'forward', 1114, 1115, 'Lake Victor');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1122, 'Hahn', 'Dawn', 1114, 'support', 1115, 1116, 'Richardland');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1116, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1117, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1118, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1119, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1120, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1121, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1126, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1127, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1128, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1129, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1130, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1131, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1112, 1116, 1117, 1118, 1119, 1120, 1121, 'development', 'white');
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1122, 1126, 1127, 1128, 1129, 1130, 1131, 'usually', 'who');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.stuid AS stuid_other, RHS.registration_date AS registration_date, RHS.election_cycle AS election_cycle, RHS.president_vote AS president_vote, RHS.vice_president_vote AS vice_president_vote, RHS.secretary_vote AS secretary_vote, RHS.treasurer_vote AS treasurer_vote, RHS.class_president_vote AS class_president_vote FROM student AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.class_senator_vote)) ORDER BY fname;

/*
Gold Result:
('Dawn',)
('Lydia',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fname FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.CLASS_Senator_VOTE;

/*
Prediction Result:
('Lydia',)
('Dawn',)
*/