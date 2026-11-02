-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1021, 'Wagner', 'Anthony', 1022, 'decide', 1023, 1024, 'Robinsonshire');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1031, 'Booth', 'Katherine', 1032, 'collection', 1033, 1034, 'Petersonberg');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1025, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1026, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1027, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1028, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1029, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1030, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1035, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1036, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1037, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1038, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1039, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1040, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1021, 1025, 1026, 1027, 1028, 1029, 1030, 'great', 'blue');
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1031, 1035, 1036, 1037, 1038, 1039, 1040, 'fall', 'table');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT registration_date, election_cycle FROM voting_record ORDER BY registration_date, election_cycle NULLS LAST;

/*
Gold Result:
('fall', 'table')
('great', 'blue')
*/

-- Prediction Query
SELECT DISTINCT Registration_Date, Election_Cycle FROM VOTING_RECORD;

/*
Prediction Result:
('great', 'blue')
('fall', 'table')
*/