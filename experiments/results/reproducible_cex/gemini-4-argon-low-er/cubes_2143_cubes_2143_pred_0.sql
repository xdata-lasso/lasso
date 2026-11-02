-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (1, 'College A', 'Leader A', 'Location A');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (1, 1, 'Bob', 'USA');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (2, 1, 'Alice', 'USA');
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 1, 'Theme 1', 4);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 2, 'Theme 1', 5);
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