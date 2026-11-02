-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'A', 'B', 'C');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 1, 'Alice', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.country AS country_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id AND LHS.member_id = RHS.member_id)) ORDER BY country;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country HAVING COUNT(*) > 2;

/*
Prediction Result:
*/