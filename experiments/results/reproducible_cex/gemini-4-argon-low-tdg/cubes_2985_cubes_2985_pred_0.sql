-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests GROUP BY (dorm_name, gender) vs GROUP BY (dorm_name) vs GROUP BY (dormid) vs GROUP BY (gender).
-- Also tests mismatch between Student.Sex and Dorm.gender (to kill mutants adding LHS.sex = RHS.gender or grouping by Sex).
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Adams', 'Amy', 18, 'F', 10, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Baker', 'Bob', 22, 'M', 10, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Clark', 'Carl', 30, 'F', 20, 2, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Davis', 'Dan', 40, 'M', 20, 2, 'LAX');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Oak Hall', 50, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Oak Hall', 60, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'Oak Hall', 70, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'Pine Hall', 80, 'F');
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 10);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (2, 2, 20);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (3, 3, 30);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (4, 4, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_t1_age_, dorm_name FROM (SELECT dorm_name, gender, AVG(age) AS meanage FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.room_number AS room_number FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.dormid AS dormid, RHS.dorm_name AS dorm_name, RHS.student_capacity AS student_capacity, RHS.gender AS gender FROM student AS LHS CROSS JOIN dorm AS RHS) AS LHS INNER JOIN lives_in AS RHS ON (LHS.stuid = RHS.stuid AND LHS.dormid = RHS.dormid)) GROUP BY dorm_name, gender) ORDER BY avg_t1_age_, dorm_name NULLS LAST;

/*
Gold Result:
(22.0, 'Oak Hall')
(24.0, 'Oak Hall')
(40.0, 'Pine Hall')
*/

-- Prediction Query
SELECT AVG(T1.age), T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid JOIN dorm AS T3 ON T3.dormid = T2.dormid GROUP BY T3.dorm_name;

/*
Prediction Result:
(23.333333333333332, 'Oak Hall')
(40.0, 'Pine Hall')
*/