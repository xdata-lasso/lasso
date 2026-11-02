-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (25, NULL, NULL, 9801, NULL, NULL, NULL, NULL);
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (36, '42', NULL, NULL);
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (22, NULL);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (NULL, 25, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_t1_age_, dorm_name FROM (SELECT dorm_name, gender, AVG(age) AS meanage FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.room_number AS room_number FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.dormid AS dormid, RHS.dorm_name AS dorm_name, RHS.student_capacity AS student_capacity, RHS.gender AS gender FROM student AS LHS CROSS JOIN dorm AS RHS) AS LHS INNER JOIN lives_in AS RHS ON (LHS.stuid = RHS.stuid AND LHS.dormid = RHS.dormid)) GROUP BY dorm_name, gender) ORDER BY avg_t1_age_, dorm_name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(T1.age), T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid JOIN dorm AS T3 ON T3.dormid = T2.dormid GROUP BY T3.dorm_name;

/*
Prediction Result:
*/