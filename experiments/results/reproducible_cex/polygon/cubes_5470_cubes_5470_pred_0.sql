-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (24, '1', '1', 1, '1', 1, 1, '1');
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (23, '1', '1', 1, '1', 1, 1, '1');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (28, '1', 1, '1');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (27, '1', 1, '1');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (26, NULL);
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (25, NULL);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (25, 27);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (26, 28);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (28, 23, 1);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (27, 24, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT amenity_name FROM (SELECT LHS.amenid AS amenid, LHS.amenity_name AS amenity_name, LHS.dormid AS dormid, LHS.n AS n FROM (SELECT LHS.amenid AS amenid, LHS.amenity_name AS amenity_name, LHS.dormid AS dormid, RHS.n AS n FROM (SELECT LHS.amenid AS amenid, LHS.amenity_name AS amenity_name, RHS.dormid AS dormid FROM dorm_amenity AS LHS INNER JOIN has_amenity AS RHS ON (LHS.amenid = RHS.amenid)) AS LHS INNER JOIN (SELECT amenid, COUNT(*) AS n FROM has_amenity GROUP BY amenid) AS RHS ON (LHS.amenid = RHS.amenid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT amenid, COUNT(*) AS n FROM has_amenity GROUP BY amenid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY amenity_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.amenity_name FROM dorm_amenity AS T1 JOIN has_amenity AS T2 ON T1.amenid = T2.amenid GROUP BY T2.amenid ORDER BY COUNT(*) DESC, T1.amenity_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/