-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Alpha College', 'Dr. Smith', 'New York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (20, 'Beta College', 'Dr. Jones', 'Boston');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (30, 'Gamma College', 'Dr. Brown', 'Seattle');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 10, 'Zack', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 20, 'Alice', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 10, 'Bob', 'Canada');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (3, 1, 'Modern', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 1, 'Classic', 3);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 2, 'Vintage', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, decoration_theme FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, decoration_theme NULLS LAST;

/*
Gold Result:
('Alice', 'Vintage')
('Zack', 'Classic')
('Zack', 'Modern')
*/

-- Prediction Query
SELECT T1.Name, T2.Decoration_Theme FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID;

/*
Prediction Result:
('Zack', 'Modern')
('Zack', 'Classic')
('Alice', 'Vintage')
*/