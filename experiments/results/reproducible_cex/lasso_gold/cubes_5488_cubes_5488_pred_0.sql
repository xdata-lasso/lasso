-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1018, 'Lindsey Roman', 1022, 'sea');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1019, 'Kimberly Dudley', 1029.0, 'available');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1020, 'Juan Calderon', 1036.0, 'answer');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1021, 'Shannon Ray', 1043.0, 'recently');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1026, 'Dylan Miller', NULL, 'raise');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1027, 'Brian Ramirez', NULL, 'away');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1028, 'Holly Wood', NULL, 'politics');
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1029, 'Derek Zuniga', NULL, 'prove');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM (SELECT dormid, dorm_name, MAX(student_capacity) OVER () AS student_capacity, gender FROM dorm) ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('Derek Zuniga',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Shannon Ray',)
*/