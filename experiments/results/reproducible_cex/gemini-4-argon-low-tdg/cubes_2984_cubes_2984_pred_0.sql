-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Smith Hall', 100, 'X');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Jones Hall', 150, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'Smith Hall', 200, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'Smith Hall Annex', 50, 'X');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (5, 'smith hall', 80, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (6, NULL, 90, 'M');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (10, 'Zebra Lounge');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (20, 'Air Conditioning');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (30, 'Air Conditioning');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (40, NULL);
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (50, 'Pool');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (60, 'Gym');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (20, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (20, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (30, 3);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (40, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (50, 2);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (50, 4);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (50, 5);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (50, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "amenity_name" FROM (SELECT "LHS"."amenid" AS "amenid", "LHS"."amenity_name" AS "amenity_name", "LHS"."dormid" AS "dormid", "RHS"."dorm_name" AS "dorm_name", "RHS"."student_capacity" AS "student_capacity", "RHS"."gender" AS "gender" FROM (SELECT "LHS"."amenid" AS "amenid", "LHS"."amenity_name" AS "amenity_name", "RHS"."dormid" AS "dormid" FROM "dorm_amenity" AS "LHS" INNER JOIN "has_amenity" AS "RHS" ON ("LHS"."amenid" = "RHS"."amenid")) AS "LHS" INNER JOIN (SELECT * FROM "dorm" WHERE ("dorm_name" = 'Smith Hall')) AS RHS ON (LHS.dormid = RHS.dormid)) ORDER BY amenity_name, "amenity_name" NULLS LAST;

/*
Gold Result:
(None,)
('Air Conditioning',)
('Air Conditioning',)
('Air Conditioning',)
('Zebra Lounge',)
*/

-- Prediction Query
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid = T3.amenid WHERE T1.dorm_name = 'Smith Hall';

/*
Prediction Result:
('Zebra Lounge',)
('Air Conditioning',)
('Air Conditioning',)
('Air Conditioning',)
(None,)
*/