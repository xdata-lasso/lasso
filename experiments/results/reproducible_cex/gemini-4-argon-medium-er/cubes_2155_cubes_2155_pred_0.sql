-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (1, 'Z_Col', 'Leader1', 'Z_Loc');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (2, 'A_Col', 'Leader2', 'A_Loc');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (1, 1, 'SameName', 'USA');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (2, 2, 'SameName', 'UK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, college_location FROM (SELECT LHS.college_id AS college_id, LHS.name AS name, LHS.leader_name AS leader_name, LHS.college_location AS college_location, RHS.member_id AS member_id, RHS.name AS name_other, RHS.country AS country FROM college AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY name, college_location NULLS LAST;

/*
Gold Result:
('SameName', 'A_Loc')
('SameName', 'Z_Loc')
*/

-- Prediction Query
SELECT T2.Name, T1.College_Location FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID ORDER BY T2.Name ASC, T1.college_id NULLS LAST, T2.member_id NULLS LAST;

/*
Prediction Result:
('SameName', 'Z_Loc')
('SameName', 'A_Loc')
*/