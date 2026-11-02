-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Smith', 21, 'F', 102, 1002, 'LAX');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (10, 'Oak Hall', 100, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (20, 'Pine Hall', 120, 'F');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (100, 'Wifi');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (200, 'Air Conditioning');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (300, 'Pool');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (100, 10);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (200, 10);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (300, 20);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (10, 1, 101);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (20, 2, 202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "amenity_name" FROM (SELECT * FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "LHS"."amenid" AS "amenid", "LHS"."amenity_name" AS "amenity_name", "RHS"."room_number" AS "room_number" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "RHS"."amenid" AS "amenid", "RHS"."amenity_name" AS "amenity_name" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."dorm_name" AS "dorm_name", "RHS"."student_capacity" AS "student_capacity", "RHS"."gender" AS "gender" FROM "student" AS "LHS" CROSS JOIN "dorm" AS "RHS") AS "LHS" CROSS JOIN "dorm_amenity" AS "RHS") AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."dormid" = "RHS"."dormid")) AS "LHS" WHERE EXISTS(SELECT 1 FROM "has_amenity" AS "RHS" WHERE ("LHS"."dormid" = "RHS"."dormid" AND "LHS"."amenid" = "RHS"."amenid"))) WHERE ("lname" = 'Smith') ORDER BY amenity_name, "amenity_name" NULLS LAST;

/*
Gold Result:
('Air Conditioning',)
('Wifi',)
*/

-- Prediction Query
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid = T3.amenid JOIN lives_in AS T4 ON T4.dormid = T1.dormid JOIN student AS T5 ON T5.stuid = T4.stuid WHERE T5.lname = 'Smith';

/*
Prediction Result:
('Wifi',)
('Air Conditioning',)
*/