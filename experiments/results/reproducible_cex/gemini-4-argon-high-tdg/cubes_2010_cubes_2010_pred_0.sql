-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'NullCity', 'Nina', 20, 'F', 100, 1, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'NullName1', NULL, 21, 'M', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'NullName2', NULL, 22, 'F', 200, 2, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Clark', 'Charlie', 19, 'M', 200, 2, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Adams', 'Alan', 23, 'M', 300, 3, 'CHI');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (1, 1, 1, 1, 1, 1, 4, '10/01/2020', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (4, 4, 4, 4, 2, 4, 4, '10/02/2020', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (4, 4, 4, 4, 3, 4, 5, '10/03/2020', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (4, 4, 4, 4, 4, 4, 5, '10/04/2020', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (4, 4, 4, 4, 5, 4, 4, '10/05/2020', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (4, 4, 4, 4, NULL, 4, 4, '10/06/2020', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."stuid" AS "stuid_other", "RHS"."registration_date" AS "registration_date", "RHS"."election_cycle" AS "election_cycle", "RHS"."president_vote" AS "president_vote", "RHS"."secretary_vote" AS "secretary_vote", "RHS"."treasurer_vote" AS "treasurer_vote", "RHS"."class_president_vote" AS "class_president_vote", "RHS"."class_senator_vote" AS "class_senator_vote" FROM (SELECT * FROM "student" WHERE ("city_code" <> 'PIT')) AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.vice_president_vote)) ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
(None,)
('Alan',)
('Charlie',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fname FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.VICE_PRESIDENT_Vote EXCEPT SELECT DISTINCT Fname FROM STUDENT WHERE city_code = 'PIT';

/*
Prediction Result:
(None,)
('Alan',)
('Charlie',)
('Nina',)
*/