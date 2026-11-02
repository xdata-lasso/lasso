-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Anonymous Donor Hall', NULL, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Anonymous Donor Hall', 100, NULL);
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'Anonymous Donor Hall', 100, 'M');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (10, 'Pool Table');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (20, 'Vending Machine');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (30, NULL);
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (40, 'Gym');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (20, 2);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (30, 3);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (40, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "amenity_name" FROM (SELECT "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "LHS"."amenid" AS "amenid", "LHS"."amenity_name" AS "amenity_name" FROM (SELECT "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "LHS"."amenid" AS "amenid", "LHS"."amenity_name" AS "amenity_name" FROM (SELECT "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "RHS"."amenid" AS "amenid", "RHS"."amenity_name" AS "amenity_name" FROM "dorm" AS "LHS" CROSS JOIN "dorm_amenity" AS "RHS") AS "LHS" INNER JOIN "has_amenity" AS "RHS" ON ("LHS"."dormid" = "RHS"."dormid" AND "LHS"."amenid" = "RHS"."amenid")) AS "LHS" INNER JOIN (SELECT * FROM "dorm" WHERE ("dorm_name" = 'Anonymous Donor Hall')) AS RHS ON (LHS.dormid = RHS.dormid AND LHS.dorm_name = RHS.dorm_name AND LHS.student_capacity = RHS.student_capacity AND LHS.gender = RHS.gender)) ORDER BY amenity_name, "amenity_name" NULLS LAST;

/*
Gold Result:
(None,)
('Gym',)
*/

-- Prediction Query
SELECT T1.amenity_name FROM dorm_amenity AS T1 JOIN has_amenity AS T2 ON T2.amenid = T1.amenid JOIN dorm AS T3 ON T2.dormid = T3.dormid WHERE T3.dorm_name = 'Anonymous Donor Hall' ORDER BY T1.amenity_name, T1.amenid NULLS LAST, T2.amenid NULLS LAST, T2.dormid NULLS LAST, T3.dormid NULLS LAST;

/*
Prediction Result:
(None,)
('Gym',)
('Pool Table',)
('Vending Machine',)
*/