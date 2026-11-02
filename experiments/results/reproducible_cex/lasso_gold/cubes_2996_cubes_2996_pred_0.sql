-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1035, 'Phillip Garcia', 1039, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1036, 'Phillip Garcia', 1046.0, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1037, 'Phillip Garcia', 1053.0, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1038, 'Phillip Garcia', 1060.0, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1043, 'Phillip Garcia', 1047, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1044, 'Phillip Garcia', 1054.0, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1045, 'Phillip Garcia', 1061.0, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1046, 'Phillip Garcia', 1068.0, 'husband');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1052, 'Monica Herrera', 1056, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1053, 'Monica Herrera', 1063.0, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1054, 'Monica Herrera', 1070.0, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1055, 'Monica Herrera', 1077.0, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1060, 'Monica Herrera', 1064, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1061, 'Monica Herrera', 1071.0, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1062, 'Monica Herrera', 1078.0, 'win');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1063, 'Monica Herrera', 1085.0, 'win');
INSERT INTO "dorm_amenity" ("amenid", "amenity_name") VALUES (1051, 'Ryan Munoz');
INSERT INTO "dorm_amenity" ("amenid", "amenity_name") VALUES (1068, 'Juan Calderon');
INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1051, 1043);
INSERT INTO "has_amenity" ("amenid", "dormid") VALUES (1068, 1060);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name, student_capacity FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, LHS.amenid AS amenid, LHS.amenity_name AS amenity_name, RHS.n AS n FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, LHS.amenid AS amenid, LHS.amenity_name AS amenity_name FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.amenid AS amenid, RHS.amenity_name AS amenity_name FROM dorm AS LHS CROSS JOIN dorm_amenity AS RHS) AS LHS INNER JOIN has_amenity AS RHS ON (LHS.dormid = RHS.dormid AND LHS.amenid = RHS.amenid)) AS LHS INNER JOIN (SELECT dorm_name, gender, COUNT(*) AS n FROM dorm GROUP BY dorm_name, gender) AS RHS ON (LHS.dorm_name = RHS.dorm_name AND LHS.gender = RHS.gender)) ORDER BY student_capacity) LIMIT 1);

/*
Gold Result:
('Phillip Garcia', 1047)
*/

-- Prediction Query
SELECT T1.dorm_name, T1.student_capacity FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid = T3.amenid GROUP BY T2.dormid ORDER BY COUNT(*), T1.dorm_name NULLS LAST, T1.student_capacity NULLS LAST LIMIT 1;

/*
Prediction Result:
('Monica Herrera', 1064)
*/