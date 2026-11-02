-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. INNER JOIN vs LEFT JOIN / FULL JOIN (Member 4 is not in round)
-- 2. SELECT vs SELECT DISTINCT (Member 1 participates in 2 rounds, should appear twice)
-- 3. ORDER BY name vs no ORDER BY / ORDER BY DESC / ORDER BY member_id (Inserted out of alphabetical order)
-- 4. Unnecessary JOIN with college (Member 3 has NULL College_ID; if inner joined with college, Member 3 is lost)
-- 5. Wrong column projections (Country, Decoration_Theme, College_ID, etc. are distinct from Name)
-- 6. Wrong join conditions (e.g., LHS.member_id = RHS.round_id or LHS.college_id = RHS.round_id)
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'College Alpha', 'Leader A', 'Loc A');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (20, 'College Beta', 'Leader B', 'Loc B');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 10, 'Charlie', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 20, 'Alice', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, NULL, 'Bob', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, 10, 'David', 'Australia');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (100, 1, 'Theme X', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (101, 1, 'Theme Y', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (100, 2, 'Theme Z', 3);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (102, 3, 'Theme W', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID ORDER BY Rank_in_Round ASC, T1.member_id NULLS LAST, T2.round_id NULLS LAST, T2.member_id NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Bob',)
('Charlie',)
('Alice',)
*/