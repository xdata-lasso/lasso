-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1040, 'Ryan', 'Robin', 1041, 'evidence', 50, 1042, 'East Julie');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1043, 'Jones', 'Stephen', 1042, 'our', 50, 1043, 'Jasonfort');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lname FROM student WHERE (major = 50) ORDER BY lname, student.stuid NULLS LAST;

/*
Gold Result:
('Jones',)
('Ryan',)
*/

-- Prediction Query
SELECT LName FROM STUDENT WHERE Major = 50;

/*
Prediction Result:
('Ryan',)
('Jones',)
*/