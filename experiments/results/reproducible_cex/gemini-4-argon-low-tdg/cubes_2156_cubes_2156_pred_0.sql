-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Col 1', 'L1', 'Loc 1');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Col 2', 'L2', 'Loc 2');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (3, 'Col 3', 'L3', 'Loc 3');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 1, 'SelfRef', 'Germany');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 3, 'Mem2', 'Japan');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 2, 'Mem3', 'Brazil');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, 1, 'Mem4', 'Spain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT college_id AS member_id, name, country, college_id, name_other, college_id_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.college_id AS college_id_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.member_id AND LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
('Germany',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Brazil',)
*/