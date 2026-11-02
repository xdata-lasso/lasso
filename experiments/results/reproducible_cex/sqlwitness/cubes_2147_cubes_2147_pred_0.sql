-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (college_id, name, leader_name, college_location) VALUES (0, 'default2', 'default1', 'default1'), (1, 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT leader_name, college_location FROM college ORDER BY leader_name, college.college_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default1')
*/

-- Prediction Query
SELECT Leader_Name, College_Location FROM college;

/*
Prediction Result:
('default1', 'default1')
(None, 'default1')
*/