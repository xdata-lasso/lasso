-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1172, 'Osborn', 'Devon', 1173, 'minute', 1174, 1175, 'Port Brandonville');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1182, 'Moore', 'Erin', 1183, 'pick', 1184, 1185, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1176, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1177, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1178, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1179, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1180, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1186, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1187, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1188, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1189, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1190, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1176, 1177, 1178, 1179, 1172, 1180, 1172, 'claim', 'product');
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1186, 1187, 1188, 1189, 1182, 1190, 1182, 'newspaper', 'enter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."stuid" AS "stuid_other", "RHS"."registration_date" AS "registration_date", "RHS"."election_cycle" AS "election_cycle", "RHS"."president_vote" AS "president_vote", "RHS"."secretary_vote" AS "secretary_vote", "RHS"."treasurer_vote" AS "treasurer_vote", "RHS"."class_president_vote" AS "class_president_vote", "RHS"."class_senator_vote" AS "class_senator_vote" FROM (SELECT * FROM "student" WHERE ("city_code" <> 'PIT')) AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.vice_president_vote)) ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
('Devon',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fname FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.VICE_PRESIDENT_Vote EXCEPT SELECT DISTINCT Fname FROM STUDENT WHERE city_code = 'PIT';

/*
Prediction Result:
('Devon',)
('Erin',)
*/