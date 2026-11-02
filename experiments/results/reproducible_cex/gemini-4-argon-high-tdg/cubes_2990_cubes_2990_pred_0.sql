-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'Alice', 19, 'F', 101, 2001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Jones', 'Bob', 20, 'M', 102, 2002, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1003, 'Taylor', 'Clara', 21, 'F', 101, 2001, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1004, 'Brown', 'Diana', 18, 'F', 103, 2003, 'LAX');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (10, 'Zeta Hall', 100, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (30, 'Alpha House', 300, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (20, 'Beta Tower', 50, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (40, 'Delta Lodge', 200, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (50, 'Gamma Court', 150, 'X');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (1, 'Wifi');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (2, 'Gym');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (1, 10);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (2, 10);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (1, 40);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (10, 1001, 101);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (10, 1003, 102);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (30, 1002, 301);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (40, 1004, 401);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dorm_name" FROM "dorm" WHERE ("gender" = 'F') ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
('Alpha House',)
('Beta Tower',)
('Zeta Hall',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm WHERE gender = 'F';

/*
Prediction Result:
('Zeta Hall',)
('Alpha House',)
('Beta Tower',)
*/