-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Stanford', 'Marc', 'California');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'MIT', 'Sally', 'Massachusetts');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (3, 'Oxford', 'Louise', 'Oxfordshire');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 2, 'Zoe', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 1, 'Alice', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, NULL, 'OrphanMember', 'UK');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 1, 'Futuristic', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 1, 'Classic', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.college_id AS college_id, LHS.name AS name, LHS.leader_name AS leader_name, LHS.college_location AS college_location, RHS.member_id AS member_id, RHS.name AS name_other, RHS.country AS country FROM college AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Alice', 'Stanford')
('Zoe', 'MIT')
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID;

/*
Prediction Result:
('Zoe', 'MIT')
('Alice', 'Stanford')
*/