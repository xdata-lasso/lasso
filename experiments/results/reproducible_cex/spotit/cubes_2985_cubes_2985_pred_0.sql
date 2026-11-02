-- Schema DDL
CREATE TABLE "STUDENT" (
    "STUID" INT,
    "LNAME" TEXT,
    "FNAME" TEXT,
    "AGE" INT,
    "SEX" TEXT,
    "MAJOR" INT,
    "ADVISOR" INT,
    "CITY_CODE" TEXT,
    PRIMARY KEY ("STUID")
);
CREATE TABLE "DORM" (
    "DORMID" INT,
    "DORM_NAME" TEXT,
    "STUDENT_CAPACITY" INT,
    "GENDER" TEXT,
    UNIQUE ("DORMID")
);
CREATE TABLE "DORM_AMENITY" (
    "AMENID" INT,
    "AMENITY_NAME" TEXT,
    UNIQUE ("AMENID")
);
CREATE TABLE "HAS_AMENITY" (
    "AMENID" INT,
    "DORMID" INT,
    FOREIGN KEY ("AMENID") REFERENCES "DORM_AMENITY"("AMENID"),
    FOREIGN KEY ("DORMID") REFERENCES "DORM"("DORMID")
);
CREATE TABLE "LIVES_IN" (
    "DORMID" INT,
    "STUID" INT,
    "ROOM_NUMBER" INT,
    FOREIGN KEY ("DORMID") REFERENCES "DORM"("DORMID"),
    FOREIGN KEY ("STUID") REFERENCES "STUDENT"("STUID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (-2147483648, 69, 70, 1, 71, -2147483648, -2147483648, 72);
INSERT INTO STUDENT VALUES (-2147483647, 73, 74, -1, 75, -2147483648, -2147483648, 76);
INSERT INTO DORM VALUES (-2147483647, -2, -2147483648, 18);
INSERT INTO DORM VALUES (-2147483648, -2, -2147483648, NULL);
INSERT INTO DORM_AMENITY VALUES (-2147483647, 0);
INSERT INTO DORM_AMENITY VALUES (-2147483648, 0);
INSERT INTO HAS_AMENITY VALUES (-2147483647, -2147483647);
INSERT INTO HAS_AMENITY VALUES (-2147483647, -2147483647);
INSERT INTO LIVES_IN VALUES (-2147483647, -2147483647, -2147483648);
INSERT INTO LIVES_IN VALUES (-2147483648, -2147483648, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_t1_age_, dorm_name FROM (SELECT dorm_name, gender, AVG(age) AS meanage FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.room_number AS room_number FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.dormid AS dormid, RHS.dorm_name AS dorm_name, RHS.student_capacity AS student_capacity, RHS.gender AS gender FROM student AS LHS CROSS JOIN dorm AS RHS) AS LHS INNER JOIN lives_in AS RHS ON (LHS.stuid = RHS.stuid AND LHS.dormid = RHS.dormid)) GROUP BY dorm_name, gender) ORDER BY avg_t1_age_, dorm_name NULLS LAST;

/*
Gold Result:
(-1.0, '-2')
(1.0, '-2')
*/

-- Prediction Query
SELECT AVG(T1.age), T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid JOIN dorm AS T3 ON T3.dormid = T2.dormid GROUP BY T3.dorm_name;

/*
Prediction Result:
(0.0, '-2')
*/