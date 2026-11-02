-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 600, 300, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 19, 'F', 520, 100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 22, 'M', 600, 300, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Taylor', 'Ann', 21, 'F', 540, 200, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Wilson', 'Tom', 20, 'M', 600, 400, 'ATL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Moore', 'Eva', 23, 'F', 520, 500, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'White', 'Sam', 18, 'M', 540, 600, NULL);
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (1, 1, 1, 1, 1, 1, 1, '08/20/2015', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (1, 1, 1, 1, 1, 1, 1, '01/15/2016', 'Spring');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (5, 5, 5, 5, 5, 5, 5, '08/20/2015', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "advisor" FROM "student" WHERE ("city_code" = 'BAL') ORDER BY advisor, student.stuid NULLS LAST;

/*
Gold Result:
(100,)
(200,)
(300,)
(300,)
*/

-- Prediction Query
SELECT Advisor FROM STUDENT WHERE city_code = 'BAL';

/*
Prediction Result:
(300,)
(100,)
(300,)
(200,)
*/