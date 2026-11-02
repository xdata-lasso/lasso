-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Alpha College', 'Dr. Smith', 'New York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (20, 'Beta College', 'Dr. Jones', 'Boston');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (30, 'Gamma College', 'Dr. Brown', 'Chicago');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 20, 'Alice', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (11, 10, 'Alice', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (12, 30, 'Bob', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (13, 30, 'Bob', 'France');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (20, 30, 'Charlie', 'Germany');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 10, 'Modern', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 11, 'Classic', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT country, member_id, MAX(n) AS n FROM (SELECT country, member_id, COUNT(*) AS n FROM (SELECT member_id, name, country, member_id AS college_id, member_id_other, country_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.member_id AS member_id_other, RHS.country AS country_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.member_id = RHS.college_id AND LHS.name = RHS.name))) GROUP BY country, member_id) GROUP BY country, member_id) ORDER BY country;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Canada',)
*/