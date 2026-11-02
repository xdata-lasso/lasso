-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1038, 'Margaret Hawkins DDS', 1033, 'forward');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1037, 'Jacob Clark', 1039.0, 'maintain');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1036, 'Timothy Wong', 1046.0, 'hundred');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1031, 'Carolyn Daniel', 1053.0, 'expect');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1039, 'Donald Reid', 1032, 'common');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1030, 'Patty Perez', 1047.0, 'difference');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1029, 'Ethan Adams', 1054.0, 'reality');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1028, 'Tommy Walter', 1061.0, 'money');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM dorm ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('Donald Reid',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tommy Walter',)
*/