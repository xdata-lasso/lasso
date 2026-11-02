-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dorm --
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483648, 'dor_39c432', 300, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'dor_39c432', 300, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'dor_39c432', 300, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483645, 'dor_39c432', 299, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483644, NULL, 300, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'dor_6d3505', NULL, '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM dorm WHERE (student_capacity >= 300) ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
(None,)
('dor_39c432',)
('dor_39c432',)
('dor_39c432',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm WHERE student_capacity > 300;

/*
Prediction Result:
*/