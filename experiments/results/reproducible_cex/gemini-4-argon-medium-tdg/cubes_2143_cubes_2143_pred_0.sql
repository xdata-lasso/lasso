-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Boundary conditions for rank_in_round > 3 (values 2, 3, 4, 5).
-- 2. Outer Join vs Inner Join (Member 5 has no rounds).
-- 3. Wrong column projection (College.Name vs Member.Name, Country, Decoration_Theme).
-- 4. Wrong join condition (Member_ID = Round_ID or Member_ID = College_ID).
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (10, 'College_Ten', 'Leader_A', 'Loc_A');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (1, 10, 'Dave', 'Country_1');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (2, 10, 'Charlie', 'Country_2');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (3, 10, 'Bob', 'Country_3');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (4, 10, 'Alice', 'Country_4');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (5, 10, 'Eve', 'Country_5');
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (101, 1, 'Theme_A', 2);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (102, 2, 'Theme_B', 3);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (103, 3, 'Theme_C', 4);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (104, 4, 'Theme_D', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN (SELECT * FROM round WHERE (rank_in_round > 3)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID WHERE T2.Rank_in_Round > 3;

/*
Prediction Result:
('Bob',)
('Alice',)
*/