-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Zack', 23, 'M', 101, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Alice', 22, 'F', 102, 11, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Alice', 24, 'F', 101, 10, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Davis', 'Bob', 21, 'M', 103, 12, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Miller', 'Alice', 25, 'F', 104, 13, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Wilson', 'Charlie', NULL, 'M', 101, 10, 'DEN');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (1, 1, 1, 1, 1, 1, 1, '2023-01-01', 'Fall');
INSERT INTO "Voting_record" ("Class_Senator_Vote", "Class_President_Vote", "Treasurer_Vote", "Secretary_Vote", "Vice_President_Vote", "President_Vote", "StuID", "Registration_Date", "Election_Cycle") VALUES (1, 2, 3, 4, 5, 6, 1, '2023-05-01', 'Spring');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname FROM student WHERE (age > 22) ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Fname FROM STUDENT WHERE Age > 22;

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/