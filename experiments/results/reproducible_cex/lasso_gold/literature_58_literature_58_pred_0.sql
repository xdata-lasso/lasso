-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" INTEGER, "dept_name" INTEGER, "credits" INTEGER);

CREATE TABLE "department" ("dept_name" INTEGER, "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" INTEGER, "salary" INTEGER, "dept_name" INTEGER);

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "semester" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" INTEGER, "dept_name" INTEGER, "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1437, 1442, 1447, 1452);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1440.0, 1447.0, 1454.0, 1461.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1443.0, 1452.0, 1461.0, 1470.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1446.0, 1457.0, 1468.0, 1479.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1449.0, 1462.0, 1475.0, 1488.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1474, 1479, 1484, 1489);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1477.0, 1484.0, 1491.0, 1498.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1480.0, 1489.0, 1498.0, 1507.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1483.0, 1494.0, 1505.0, 1516.0);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1486.0, 1499.0, 1512.0, 1525.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1437, 1457, 1458, 1463, 1464, 1469);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1440.0, 1457, 1465.0, 1463, 1475.0, 1482.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1443.0, 1457, 1472.0, 1463, 1486.0, 1495.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1446.0, 1457, 1479.0, 1463, 1497.0, 1508.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1449.0, 1457, 1486.0, 1463, 1508.0, 1521.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1474, 1494, 1495, 1463, 1500, 1505);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1477.0, 1494, 1502.0, 1463, 1511.0, 1518.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1480.0, 1494, 1509.0, 1463, 1522.0, 1531.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1483.0, 1494, 1516.0, 1463, 1533.0, 1544.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1486.0, 1494, 1523.0, 1463, 1544.0, 1557.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
(2926,)
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(1463,)
*/