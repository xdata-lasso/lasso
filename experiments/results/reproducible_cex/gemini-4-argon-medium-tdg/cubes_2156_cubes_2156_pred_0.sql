-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'College A', 'Leader A', 'Loc A');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'College B', 'Leader B', 'Loc B');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (3, 'College C', 'Leader C', 'Loc C');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (4, 'College D', 'Leader D', 'Loc D');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (99, 'College Z', 'Leader Z', 'Loc Z');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 99, 'Mem 1', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 1, 'Mem 10', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (11, 1, 'Mem 11', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 99, 'Mem 2', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (20, 2, 'Mem 20', 'Mexico');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (30, 3, 'Mem 30', 'Brazil');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, 99, 'Mem 4', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (40, 4, 'Mem 40', 'UK');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 1, 'Theme A', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT college_id AS member_id, name, country, college_id, name_other, college_id_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.college_id AS college_id_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.member_id AND LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
('UK',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/