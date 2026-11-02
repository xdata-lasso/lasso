-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Tech University', 'Charlie', 'Boston');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Zeta Institute', 'Alice', 'York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (3, 'Alpha College', 'Alice', 'Austin');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (4, 'Med School', 'Bob', 'Denver');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (5, 'Law School', 'Bob', 'Denver');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (101, 2, 'David', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (102, 2, 'Eva', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (103, 3, 'Frank', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (104, 4, 'Grace', 'USA');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 101, 'Modern', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 101, 'Classic', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 103, 'Rustic', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT leader_name, college_location FROM college ORDER BY leader_name, college.college_id NULLS LAST;

/*
Gold Result:
('Alice', 'York')
('Alice', 'Austin')
('Bob', 'Denver')
('Bob', 'Denver')
('Charlie', 'Boston')
*/

-- Prediction Query
SELECT Leader_Name, College_Location FROM college;

/*
Prediction Result:
('Charlie', 'Boston')
('Alice', 'York')
('Alice', 'Austin')
('Bob', 'Denver')
('Bob', 'Denver')
*/