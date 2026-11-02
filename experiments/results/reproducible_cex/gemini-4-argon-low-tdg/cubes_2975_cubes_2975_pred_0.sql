-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY fname, lname (including tie-breakers on fname) and duplicate preservation (bag semantics vs DISTINCT).
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (201, 'North Dorm', 200, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (202, 'South Dorm', 200, 'M');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (10, 'TV Lounge');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 201);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 202);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 202);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2001, 'Zeta', 'Alice', 20, 'F', 100, 1, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2002, 'Alpha', 'Alice', 22, 'F', 100, 1, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2003, 'Beta', 'Bob', 21, 'M', 200, 2, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2004, 'Beta', 'Bob', 19, 'M', 300, 3, 'MIA');
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (201, 2001, 10);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (201, 2002, 20);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (202, 2003, 30);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (201, 2004, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."amenid" AS "amenid", "LHS"."room_number" AS "room_number", "RHS"."amenity_name" AS "amenity_name" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."amenid" AS "amenid", "RHS"."room_number" AS "room_number" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."amenid" AS "amenid" FROM "student" AS "LHS" CROSS JOIN "has_amenity" AS "RHS") AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."dormid" = "RHS"."dormid")) AS "LHS" INNER JOIN (SELECT * FROM "dorm_amenity" WHERE ("amenity_name" = 'TV Lounge')) AS RHS ON (LHS.amenid = RHS.amenid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Alice', 'Alpha')
('Alice', 'Zeta')
('Bob', 'Beta')
('Bob', 'Beta')
('Bob', 'Beta')
*/

-- Prediction Query
SELECT T1.fname, T1.lname FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid WHERE T2.dormid IN (SELECT T3.dormid FROM has_amenity AS T3 JOIN dorm_amenity AS T4 ON T3.amenid = T4.amenid WHERE T4.amenity_name = 'TV Lounge');

/*
Prediction Result:
('Alice', 'Zeta')
('Alice', 'Alpha')
('Bob', 'Beta')
('Bob', 'Beta')
*/