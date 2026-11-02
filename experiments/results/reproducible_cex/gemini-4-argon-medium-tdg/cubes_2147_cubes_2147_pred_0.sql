-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Alpha College', 'Zack', 'Boston');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Beta College', 'Alice', 'New York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (3, 'Gamma College', 'Alice', 'Chicago');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (4, 'Delta College', 'Bob', 'Austin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT leader_name, college_location FROM college ORDER BY leader_name, college.college_id NULLS LAST;

/*
Gold Result:
('Alice', 'New York')
('Alice', 'Chicago')
('Bob', 'Austin')
('Zack', 'Boston')
*/

-- Prediction Query
SELECT Leader_Name, College_Location FROM college;

/*
Prediction Result:
('Zack', 'Boston')
('Alice', 'New York')
('Alice', 'Chicago')
('Bob', 'Austin')
*/