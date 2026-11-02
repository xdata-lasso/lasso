-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 100, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Johnson', 'Mary', 21, 'F', 300, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Williams', 'Bob', 22, 'M', 400, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Brown', 'Alice', 19, 'F', 600, 1004, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Jones', 'Charlie', 23, 'M', 500, 1005, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Garcia', 'Diana', 20, 'F', 700, 1006, 'MIA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Miller', 'Evan', 24, 'M', 800, 1007, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Davis', 'Fiona', 18, 'F', 200, 1008, 'SFO');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (9, 'Rodriguez', 'George', 25, 'M', 900, 1009, 'DAL');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 3, 4, 5, 6, 7, 1, '2022-09-01', 'Fall2022');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 3, 4, 5, 6, 7, 1, '2023-03-01', 'Spring2023');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 3, 8, 5, 6, 7, 2, '2023-03-02', 'Spring2023');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT major FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.stuid AS stuid_other, RHS.registration_date AS registration_date, RHS.election_cycle AS election_cycle, RHS.president_vote AS president_vote, RHS.vice_president_vote AS vice_president_vote, RHS.secretary_vote AS secretary_vote, RHS.class_president_vote AS class_president_vote, RHS.class_senator_vote AS class_senator_vote FROM student AS LHS INNER JOIN voting_record AS RHS ON (LHS.stuid = RHS.treasurer_vote)) ORDER BY major;

/*
Gold Result:
(200,)
(600,)
*/

-- Prediction Query
SELECT DISTINCT T1.Major FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = T2.Treasurer_Vote;

/*
Prediction Result:
(600,)
(200,)
*/