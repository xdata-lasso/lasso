-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1098, 'Wright', 'Brenda', 1101, 'discuss', 1104, 1107, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1099, 'Hoffman', 'Rachael', 1110.0, 'certainly', 1117.0, 1122.0, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1100, 'Baker', 'Reginald', 1119.0, 'Mr', 1130.0, 1137.0, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1110, 'Callahan', 'Erin', 1113, 'pick', 1116, 1119, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1111, 'Hernandez', 'Candace', 1122.0, 'management', 1129.0, 1134.0, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1112, 'Moore', 'Paul', 1131.0, 'newspaper', 1142.0, 1149.0, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1122, 'Frazier', 'Karen', 1125, 'finally', 1128, 1131, 'New Rita');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1123, 'Wilson', 'Kayla', 1134.0, 'learn', 1141.0, 1146.0, 'New Rita');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1124, 'Dyer', 'Matthew', 1143.0, 'coach', 1154.0, 1161.0, 'New Rita');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, city_code FROM (SELECT city_code, COUNT(*) AS n FROM student GROUP BY city_code) WHERE (n > 1) ORDER BY count___, city_code NULLS LAST;

/*
Gold Result:
(3, 'New Rita')
(6, 'Daviston')
*/

-- Prediction Query
SELECT COUNT(*), city_code FROM student GROUP BY city_code HAVING COUNT(*) > 1;

/*
Prediction Result:
(6, 'Daviston')
(3, 'New Rita')
*/