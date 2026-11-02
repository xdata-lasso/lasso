-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'Linda', 18, 'F', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Tracy', 'Kim', 19, 'F', 600, 7712, 'HKG');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Jones', 'Shiela', 21, 'F', 600, 7792, 'WAS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Woods', 'Eric', 20, 'M', 520, 8722, 'NYC');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (1, 2, 3, 4, 1, 2, 1, '09/15/2015', 'Spring');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 3, 4, 1, 2, 3, 2, '09/15/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (3, 4, 1, 2, 3, 4, 3, '08/30/2015', 'Spring');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (4, 1, 2, 3, 4, 1, 4, '08/30/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (1, 3, 2, 4, 1, 3, 2, '08/30/2015', 'Fall');
INSERT INTO Voting_record (Class_Senator_Vote, Class_President_Vote, Treasurer_Vote, Secretary_Vote, Vice_President_Vote, President_Vote, StuID, Registration_Date, Election_Cycle) VALUES (2, 1, 4, 3, 2, 1, 3, '09/15/2015', 'Spring');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT registration_date, election_cycle FROM voting_record ORDER BY registration_date, election_cycle NULLS LAST;

/*
Gold Result:
('08/30/2015', 'Fall')
('08/30/2015', 'Spring')
('09/15/2015', 'Fall')
('09/15/2015', 'Spring')
*/

-- Prediction Query
SELECT DISTINCT Registration_Date, Election_Cycle FROM VOTING_RECORD;

/*
Prediction Result:
('09/15/2015', 'Spring')
('09/15/2015', 'Fall')
('08/30/2015', 'Spring')
('08/30/2015', 'Fall')
*/