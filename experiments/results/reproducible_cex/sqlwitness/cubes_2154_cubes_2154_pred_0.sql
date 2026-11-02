-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (college_id, name, leader_name, college_location) VALUES (0, 'default2', NULL, 'default1'), (1, 'Canada', 'default1', 'Canada'), (2, 'Canada', 'default2', 'Canada'), (3, 'Canada', 'Canada', 'default2'), (4, 'Canada', 'default2', 'default2'), (5, 'default1', 'default1', 'default1'), (6, 'Canada', 'Canada', 'Canada'), (7, 'default2', 'default1', 'default2'), (8, 'default2', 'default2', 'default2');
INSERT INTO member (member_id, college_id, name, country) VALUES (1, NULL, 'default2', 'default2'), (0, 1, 'default1', 'default2'), (2, NULL, 'default2', NULL), (3, 2, 'Canada', NULL), (4, 7, NULL, NULL), (5, 5, 'Canada', 'Canada'), (6, 0, 'default2', 'Canada'), (7, 6, 'Canada', 'Canada'), (8, 1, 'default1', 'Canada'), (9, 1, 'default1', 'default1'), (10, 4, 'default1', 'default2'), (11, 4, 'default1', NULL), (12, 2, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "leader_name" FROM (SELECT "LHS"."college_id" AS "college_id", "LHS"."name" AS "name", "LHS"."leader_name" AS "leader_name", "LHS"."college_location" AS "college_location", "RHS"."member_id" AS "member_id", "RHS"."name" AS "name_other", "RHS"."country" AS "country" FROM "college" AS "LHS" INNER JOIN (SELECT * FROM "member" WHERE ("country" = 'Canada')) AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY leader_name, "leader_name" NULLS LAST;

/*
Gold Result:
(None,)
('Canada',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T1.Leader_Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID WHERE T2.Country = 'Canada';

/*
Prediction Result:
('default1',)
(None,)
('Canada',)
*/