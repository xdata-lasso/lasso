-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core logic, ORDER BY, NULLS LAST, and filtering out non-matching dorms and students without dorms
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Smith Hall', 100, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Jones Hall', 150, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'smith hall', 100, 'X');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Doe', 'Zack', 20, 'M', 600, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Smith', 'Alice', 19, 'F', 600, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Brown', NULL, 21, 'F', 500, 1003, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (104, 'White', 'Bob', 22, 'M', 400, 1004, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (105, 'Green', 'Charlie', 20, 'M', 300, 1005, 'MIA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (106, 'Black', 'Eve', 18, 'F', 200, 1006, 'SEA');
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 101, 10);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 102, 11);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 103, 12);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (2, 104, 20);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (3, 106, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "LHS"."room_number" AS "room_number" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "RHS"."room_number" AS "room_number" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."dorm_name" AS "dorm_name", "RHS"."student_capacity" AS "student_capacity", "RHS"."gender" AS "gender" FROM "student" AS "LHS" CROSS JOIN "dorm" AS "RHS") AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."dormid" = "RHS"."dormid")) AS "LHS" INNER JOIN (SELECT * FROM "dorm" WHERE ("dorm_name" = 'Smith Hall')) AS RHS ON (LHS.dormid = RHS.dormid AND LHS.dorm_name = RHS.dorm_name AND LHS.student_capacity = RHS.student_capacity AND LHS.gender = RHS.gender)) ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T1.fname FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid JOIN dorm AS T3 ON T3.dormid = T2.dormid WHERE T3.dorm_name = 'Smith Hall';

/*
Prediction Result:
('Zack',)
('Alice',)
(None,)
*/