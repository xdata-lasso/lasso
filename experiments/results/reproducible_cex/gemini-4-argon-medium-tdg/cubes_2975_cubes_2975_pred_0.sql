-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Zeta', 'Alex', 20, 'M', 100, 10, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Alpha', 'Alex', 21, 'F', 100, 10, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, NULL, 'Alex', 22, 'M', 100, 10, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Beta', 'Zack', 19, 'M', 100, 10, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Gamma', NULL, 20, 'F', 100, 10, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, NULL, NULL, 23, 'M', 100, 10, 'SFO');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Main Dorm', 200, 'X');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (10, 'TV Lounge');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 1);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 101);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 2, 102);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 3, 103);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 4, 104);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 5, 105);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 6, 106);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."amenid" AS "amenid", "LHS"."room_number" AS "room_number", "RHS"."amenity_name" AS "amenity_name" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."amenid" AS "amenid", "RHS"."room_number" AS "room_number" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."amenid" AS "amenid" FROM "student" AS "LHS" CROSS JOIN "has_amenity" AS "RHS") AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."dormid" = "RHS"."dormid")) AS "LHS" INNER JOIN (SELECT * FROM "dorm_amenity" WHERE ("amenity_name" = 'TV Lounge')) AS RHS ON (LHS.amenid = RHS.amenid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
(None, 'Gamma')
(None, None)
('Alex', 'Alpha')
('Alex', 'Zeta')
('Alex', None)
('Zack', 'Beta')
*/

-- Prediction Query
SELECT T1.fname, T1.lname FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid WHERE T2.dormid IN (SELECT T3.dormid FROM has_amenity AS T3 JOIN dorm_amenity AS T4 ON T3.amenid = T4.amenid WHERE T4.amenity_name = 'TV Lounge');

/*
Prediction Result:
('Alex', 'Zeta')
('Alex', 'Alpha')
('Alex', None)
('Zack', 'Beta')
(None, 'Gamma')
(None, None)
*/