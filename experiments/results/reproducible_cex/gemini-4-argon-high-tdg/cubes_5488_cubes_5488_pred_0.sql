-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Doe', 'Jane', 19, 'F', 600, 1121, 'NYC');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (9, 'Maple Hall', 600, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (100, 'Oak Hall', 250, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (20, 'Pine Hall', 100, 'F');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (1, 'WiFi');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (1, 9);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (1, 20);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (9, 1002, 101);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (20, 1001, 202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM (SELECT dormid, dorm_name, MAX(student_capacity) OVER () AS student_capacity, gender FROM dorm) ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('Oak Hall',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Maple Hall',)
*/