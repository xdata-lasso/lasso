-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Uni A', 'Dr. Smith', 'NY');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Uni B', 'Dr. Jones', 'CA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 1, 'Zack', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (20, 1, 'Alice', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (30, 2, 'Bob', 'UK');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 10, 'Modern', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 10, 'Classic', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 20, 'Modern', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
('Zack',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID ORDER BY Rank_in_Round ASC, T1.member_id NULLS LAST, T2.round_id NULLS LAST, T2.member_id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Alice',)
('Zack',)
*/