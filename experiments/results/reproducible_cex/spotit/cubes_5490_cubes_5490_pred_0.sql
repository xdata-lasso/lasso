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
INSERT INTO STUDENT VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STUDENT VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO DORM VALUES (0, 26, 100, 27);
INSERT INTO DORM VALUES (-1, 28, 99, 29);
INSERT INTO DORM_AMENITY VALUES (0, 0);
INSERT INTO DORM_AMENITY VALUES (1, 0);
INSERT INTO HAS_AMENITY VALUES (1, 0);
INSERT INTO HAS_AMENITY VALUES (1, -1);
INSERT INTO LIVES_IN VALUES (0, 1, 0);
INSERT INTO LIVES_IN VALUES (-1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, dormid FROM (SELECT dormid, COUNT(*) AS n FROM (SELECT * FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.amenid AS amenid FROM dorm AS LHS INNER JOIN has_amenity AS RHS ON (LHS.dormid = RHS.dormid)) WHERE (student_capacity >= 100)) GROUP BY dormid) ORDER BY count___, dormid NULLS LAST;

/*
Gold Result:
(1, 0)
*/

-- Prediction Query
SELECT COUNT(*), T1.dormid FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid WHERE T1.student_capacity > 100 GROUP BY T1.dormid;

/*
Prediction Result:
*/