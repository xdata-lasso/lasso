-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" TEXT(255), "dept_name" TEXT(255), "credits" INTEGER);

CREATE TABLE "department" ("dept_name" TEXT(255), "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" TEXT(255), "salary" INTEGER, "dept_name" TEXT(255));

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" TEXT(255), "dept_name" TEXT(255), "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1257, 'Larry Dixon', 1262, 'Erin Edwards');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1260.0, 'Kenneth Scott', 1269.0, 'Michelle Evans');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1263.0, 'April Frost', 1276.0, 'Jason Powell');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1266.0, 'Michelle Harmon', 1283.0, 'Cameron Fisher');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1269.0, 'Helen Jones', 1290.0, 'Megan Orr');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1279, 'Elizabeth Kelley', 1284, 'Jose Schultz');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1282.0, 'Dustin Jordan', 1291.0, 'Robert Potter');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1285.0, 'Mary Marshall', 1298.0, 'Courtney Gonzalez');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1288.0, 'Daniel Kennedy', 1305.0, 'David Alvarez');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1291.0, 'Rebecca Jackson', 1312.0, 'Angel Perry');
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1257, 1267, 1268, 1273, 1274);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1260.0, 1267, 1275.0, 1273, 1285.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1263.0, 1267, 1282.0, 1273, 1296.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1266.0, 1267, 1289.0, 1273, 1307.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1269.0, 1267, 1296.0, 1273, 1318.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1279, 1289, 1290, 1273, 1295);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1282.0, 1289, 1297.0, 1273, 1306.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1285.0, 1289, 1304.0, 1273, 1317.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1288.0, 1289, 1311.0, 1273, 1328.0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1291.0, 1289, 1318.0, 1273, 1339.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
(2546,)
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(1273,)
*/