-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dorm --
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'dor_7870c7', 1, 'dor_d6fe73');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483647, 'dor_2a78dd', 1, 'dor_b506bc');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'dor_6d3505', -55602865, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483648, 'dor_6d3505', -59984348, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483644, 'q_1_5847d5', -664303813, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483643, 'q_1_5847d5', -1022641847, '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM dorm ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('dor_6d3505',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('dor_2a78dd',)
*/