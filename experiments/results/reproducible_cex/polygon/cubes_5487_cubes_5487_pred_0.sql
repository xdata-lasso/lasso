-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (30, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (31, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (36, NULL, NULL, 'M52');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (45, 'M61', 51, 'M');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (29, NULL);
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (NULL, NULL);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (29, 36);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (29, 45);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (36, 31, NULL);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (45, 31, 46);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."room_number" AS "room_number", "LHS"."gender" AS "gender", "LHS"."student_capacity" AS "student_capacity", "LHS"."n_distinct" AS "n_distinct" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."room_number" AS "room_number", "RHS"."gender" AS "gender", "RHS"."student_capacity" AS "student_capacity", "RHS"."n_distinct" AS "n_distinct" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."room_number" AS "room_number" FROM "student" AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" CROSS JOIN (SELECT "gender", "student_capacity", COUNT(DISTINCT "gender") AS "n_distinct" FROM "dorm" GROUP BY "gender", "student_capacity") AS "RHS") AS "LHS" INNER JOIN (SELECT * FROM (SELECT "gender", "student_capacity", COUNT(DISTINCT "gender") AS "n_distinct" FROM "dorm" GROUP BY "gender", "student_capacity") WHERE ("gender" <> 'M')) AS RHS ON (LHS.gender = RHS.gender AND LHS.student_capacity = RHS.student_capacity AND LHS.n_distinct = RHS.n_distinct)) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid JOIN dorm AS T3 ON T3.dormid = T2.dormid WHERE T3.gender = 'M';

/*
Prediction Result:
(1,)
*/