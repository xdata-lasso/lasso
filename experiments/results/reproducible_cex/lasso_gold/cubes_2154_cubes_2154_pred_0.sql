-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1020, 'Kimberly Smith', 'Paul Young', '60260 Baker Tunnel Suite 468
Mooreport, IL 08166');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1024, 'James Powers', 'Eugene Walton', '911 William Curve Suite 135
Ericside, VT 40152');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1021, 1020, 'Kimberly Adkins', 'Canada');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1023, 1020, 'Christina Moran', 'Canada');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1025, 1024, 'Victoria Valdez', 'Canada');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "leader_name" FROM (SELECT "LHS"."college_id" AS "college_id", "LHS"."name" AS "name", "LHS"."leader_name" AS "leader_name", "LHS"."college_location" AS "college_location", "RHS"."member_id" AS "member_id", "RHS"."name" AS "name_other", "RHS"."country" AS "country" FROM "college" AS "LHS" INNER JOIN (SELECT * FROM "member" WHERE ("country" = 'Canada')) AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY leader_name, "leader_name" NULLS LAST;

/*
Gold Result:
('Eugene Walton',)
('Paul Young',)
*/

-- Prediction Query
SELECT DISTINCT T1.Leader_Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID WHERE T2.Country = 'Canada';

/*
Prediction Result:
('Paul Young',)
('Eugene Walton',)
*/