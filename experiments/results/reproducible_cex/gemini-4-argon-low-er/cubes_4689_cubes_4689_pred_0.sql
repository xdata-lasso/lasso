-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (99, 'Tech', 'Leader', 'City');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 99, 'Alice', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT country, member_id, MAX(n) AS n FROM (SELECT country, member_id, COUNT(*) AS n FROM (SELECT member_id, name, country, member_id AS college_id, member_id_other, country_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.member_id AS member_id_other, RHS.country AS country_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.member_id = RHS.college_id AND LHS.name = RHS.name))) GROUP BY country, member_id) GROUP BY country, member_id) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/