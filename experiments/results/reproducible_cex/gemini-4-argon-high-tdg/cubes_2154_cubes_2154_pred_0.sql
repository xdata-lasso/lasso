-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (1, 'Oakridge', 'Zoe', 'USA');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (2, 'Maple', 'Alice', 'Canada');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (3, 'Pine', 'Bob', 'UK');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (4, 'Cedar', 'Bob', 'France');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (5, 'Birch', 'Charlie', 'Canada');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (101, 1, 'MemA', 'Canada');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (102, 1, 'MemB', 'Canada');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (103, 2, 'MemC', 'USA');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (104, 3, 'MemD', 'Canada');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (105, 3, 'MemE', 'UK');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (106, 4, 'MemF', 'Canada');
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 101, 'Modern', 1);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (2, 101, 'Classic', 2);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 103, 'Modern', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "leader_name" FROM (SELECT "LHS"."college_id" AS "college_id", "LHS"."name" AS "name", "LHS"."leader_name" AS "leader_name", "LHS"."college_location" AS "college_location", "RHS"."member_id" AS "member_id", "RHS"."name" AS "name_other", "RHS"."country" AS "country" FROM "college" AS "LHS" INNER JOIN (SELECT * FROM "member" WHERE ("country" = 'Canada')) AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY leader_name, "leader_name" NULLS LAST;

/*
Gold Result:
('Bob',)
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT T1.Leader_Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID WHERE T2.Country = 'Canada';

/*
Prediction Result:
('Zoe',)
('Bob',)
*/