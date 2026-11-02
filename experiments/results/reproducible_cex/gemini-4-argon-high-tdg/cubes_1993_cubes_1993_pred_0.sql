-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 600, 100, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 19, 'F', 600, 100, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Brown', 'Bob', 21, 'M', 520, 20, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'White', 'Alice', 22, 'F', 520, 20, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Green', 'Tom', 18, 'M', 550, 10, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Black', 'Eve', 20, 'F', 550, 10, 'MIA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Adams', 'Sam', 23, 'M', 600, 1, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (30, 'Clark', 'Mia', 19, 'F', 600, 2, 'DAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (100, 'Lewis', 'Zoe', 21, 'F', 520, 3, 'SFO');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (1, 2, 3, 4, 5, 20, 1, '08/30/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 3, 4, 5, 1, 100, 2, '08/30/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (3, 4, 5, 1, 2, 20, 3, '08/30/2015', 'Spring');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (5, 4, 3, 2, 1, 2, 4, '08/30/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (1, 1, 1, 1, 1, 10, 5, '08/29/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 2, 2, 2, 2, 30, 10, '08/31/2015', 'Fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "president_vote" FROM "voting_record" WHERE ("registration_date" = '08/30/2015') ORDER BY president_vote, "president_vote" NULLS LAST;

/*
Gold Result:
(2,)
(20,)
(100,)
*/

-- Prediction Query
SELECT DISTINCT PRESIDENT_Vote FROM VOTING_RECORD WHERE Registration_Date = '08/30/2015';

/*
Prediction Result:
(20,)
(100,)
(2,)
*/