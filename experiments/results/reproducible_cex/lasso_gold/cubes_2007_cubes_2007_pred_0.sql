-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1112, 'Parsons', 'Jeremy', 1112, 'almost', 1113, 1114, 'Richardland');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1111, 'Gentry', 'Ashley', 1122, 'serious', 1123, 1124, 'Jasonfort');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1115, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1116, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1117, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1118, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1119, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1120, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1125, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1126, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1127, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1128, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1129, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1130, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1115, 1116, 1117, 1112, 1118, 1119, 1120, 'development', 'Fall');
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1125, 1126, 1127, 1111, 1128, 1129, 1130, 'individual', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "secretary_vote" FROM "voting_record" WHERE ("election_cycle" = 'Fall') ORDER BY secretary_vote, "secretary_vote" NULLS LAST;

/*
Gold Result:
(1111,)
(1112,)
*/

-- Prediction Query
SELECT DISTINCT Secretary_Vote FROM VOTING_RECORD WHERE ELECTION_CYCLE = 'Fall';

/*
Prediction Result:
(1112,)
(1111,)
*/