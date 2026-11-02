-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Zimmer', 'Alice', 20, 'F', 50, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Adams', 'Bob', 21, 'M', 50, 102, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (30, 'Baker', 'Charlie', 22, 'M', 50, 103, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (40, 'Adams', 'Diana', 19, 'F', 50, 104, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (50, 'WrongID', 'Eve', 20, 'F', 49, 105, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (60, 'WrongAge', 'Frank', 50, 'M', 51, 106, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (70, 'WrongAdv', 'Grace', 23, 'F', 0, 50, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (80, 'NullMaj', 'Hank', 24, 'M', NULL, 107, 'BOS');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (10, 20, 30, 40, 50, 60, 10, '2023-01-01', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (20, 10, 30, 40, 50, 60, 10, '2023-05-01', 'Spring');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (50, 50, 50, 50, 50, 50, 50, '2023-01-01', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lname FROM student WHERE (major = 50) ORDER BY lname, student.stuid NULLS LAST;

/*
Gold Result:
('Adams',)
('Adams',)
('Baker',)
('Zimmer',)
*/

-- Prediction Query
SELECT LName FROM STUDENT WHERE Major = 50;

/*
Prediction Result:
('Zimmer',)
('Adams',)
('Baker',)
('Adams',)
*/