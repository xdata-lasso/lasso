-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dorm --
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'dor_6d3505', -55602865, '7');

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_980d32', 'lhs_90df1f', 1, 'lhs_fad4bd', 1, 1, 'lhs_9d1675');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'lhs_f3941a', 'lhs_c53aa3', 1, 'lhs_0b5eac', 1, 1, 'lhs_d2cd5b');

-- Inserting into table: dorm_amenity --
INSERT INTO "dorm_amenity" ("amenid", "amenity_name") VALUES (1, 'TV Lounge');

INSERT INTO "dorm_amenity" ("amenid", "amenity_name") VALUES (-2147483647, 'TV Lounge');

-- Inserting into table: has_amenity --
INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1, 1);

-- Inserting into table: lives_in --
INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, NULL);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, -2147483647, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."amenid" AS "amenid", "LHS"."room_number" AS "room_number", "RHS"."amenity_name" AS "amenity_name" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."amenid" AS "amenid", "RHS"."room_number" AS "room_number" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."amenid" AS "amenid" FROM "student" AS "LHS" CROSS JOIN "has_amenity" AS "RHS") AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."dormid" = "RHS"."dormid")) AS "LHS" INNER JOIN (SELECT * FROM "dorm_amenity" WHERE ("amenity_name" = 'TV Lounge')) AS RHS ON (LHS.amenid = RHS.amenid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
*/

-- Prediction Query
SELECT T1.fname, T1.lname FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid WHERE T2.dormid IN (SELECT T3.dormid FROM has_amenity AS T3 JOIN dorm_amenity AS T4 ON T3.amenid = T4.amenid WHERE T4.amenity_name = 'TV Lounge');

/*
Prediction Result:
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_90df1f', 'lhs_980d32')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
('lhs_c53aa3', 'lhs_f3941a')
*/