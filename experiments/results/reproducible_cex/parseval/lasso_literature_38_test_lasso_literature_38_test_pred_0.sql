-- Schema DDL
CREATE TABLE course (course_id INTEGER, title TEXT(255), dept_name TEXT(255), credits INTEGER);

CREATE TABLE department (dept_name TEXT(255), building INTEGER, budget INTEGER);

CREATE TABLE instructor (ID INTEGER, name TEXT(255), salary INTEGER, dept_name TEXT(255));

CREATE TABLE teaches (ID INTEGER, course_id INTEGER, sec_id INTEGER, year INTEGER, instructor INTEGER);

CREATE TABLE section (course_id INTEGER, sec_id INTEGER, year INTEGER, building INTEGER, room_number INTEGER, time_slot_id INTEGER);

CREATE TABLE takes (ID INTEGER, course_id INTEGER, sec_id INTEGER, year INTEGER, grade INTEGER);

CREATE TABLE student (ID INTEGER, name TEXT(255), dept_name TEXT(255), tot_cred INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-55602865, 'cou_aa4396', 'c_s_ff229f', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-59984348, 'cou_aa4396', 'c_s_ff229f', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-664303813, 'cou_aa4396', 'c_s_ff229f', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1022641847, 'cou_aa4396', 'c_s_ff229f', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1726781632, 'cou_aa4396', 'c_s_ff229f', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (247012447, 'cou_aa4396', 'c_s_ff229f', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1744686505, 'cou_aa4396', 'c_s_ff229f', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1633151678, 'cou_aa4396', 'c_s_ff229f', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-252690330, 'cou_aa4396', 'c_s_ff229f', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1115440883, 'cou_aa4396', 'c_s_ff229f', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1644814318, 'cou_aa4396', 'c_s_ff229f', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1465859724, 'cou_aa4396', 'c_s_ff229f', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1610064545, 'cou_aa4396', '?', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (429706943, 'cou_aa4396', '?', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (462974032, 'cou_aa4396', '?', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1137908826, 'cou_aa4396', '?', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-918961358, 'cou_aa4396', '?', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1602639011, 'cou_aa4396', '?', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (44952191, 'cou_aa4396', 'A', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1151980946, 'cou_aa4396', 'A', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1620389964, 'cou_aa4396', 'A', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (546571701, 'cou_aa4396', 'A', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (947159877, 'cou_aa4396', 'A', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1990080517, 'cou_aa4396', 'A', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1149850321, 'cou_aa4396', 'A', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1833165707, 'cou_aa4396', 'A', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1155439218, 'cou_aa4396', 'A', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1313172851, 'cou_aa4396', 'A', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-761141909, 'cou_aa4396', 'A', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (283598170, 'cou_aa4396', 'A', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (902887186, 'cou_aa4396', 'A', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-967741825, 'cou_aa4396', 'A', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (775304493, 'cou_aa4396', 'A', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (373262291, 'cou_aa4396', 'A', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-472966518, 'cou_aa4396', 'A', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-921187550, 'cou_aa4396', 'A', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-751275471, 'cou_aa4396', 'c_s_ff229f', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1347802441, 'cou_aa4396', 'c_s_ff229f', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1673584235, 'cou_aa4396', 'c_s_ff229f', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-2118135981, 'cou_aa4396', 'c_s_ff229f', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2074205376, 'cou_aa4396', 'c_s_ff229f', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (274769912, 'cou_aa4396', 'c_s_ff229f', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (90119032, 'cou_aa4396', 'c_s_ff229f', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1438850342, 'cou_aa4396', 'c_s_ff229f', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-305670381, 'cou_aa4396', 'c_s_ff229f', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1525670226, 'cou_aa4396', 'c_s_ff229f', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-453362185, 'cou_aa4396', 'c_s_ff229f', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (481163439, 'cou_aa4396', 'c_s_ff229f', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-953437896, 'cou_aa4396', 'c_s_ff229f', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1097120355, 'cou_aa4396', 'c_s_ff229f', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (244829661, 'cou_aa4396', 'c_s_ff229f', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1362461264, 'cou_aa4396', 'c_s_ff229f', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-904834265, 'cou_aa4396', 'c_s_ff229f', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-346339240, 'cou_aa4396', 'c_s_ff229f', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-227162283, 'cou_aa4396', 'c_s_ff229f', 2);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2056419640, 'cou_aa4396', 'c_s_ff229f', 3);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (222415430, 'cou_aa4396', 'c_s_ff229f', 4);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (556727997, 'cou_aa4396', 'c_s_ff229f', 5);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1178000634, 'cou_aa4396', 'c_s_ff229f', 6);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1836127587, 'cou_aa4396', 'c_s_ff229f', 7);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (910894705, 'cou_aa4396', 'c_s_ff229f', NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-283454505, 'cou_aa4396', 'c_s_ff229f', NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (233994589, 'cou_aa4396', 'c_s_ff229f', NULL);

-- Inserting into table: department --
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', -1980249628, -734455130);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', -1349201381, 1019800248);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', -1910425938, -845863578);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('@', -45536098, 1861536320);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('@', 1408123494, -1964997180);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('@', 742285925, -747753377);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('@', -2070843029, 328305758);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', -188151580, 226938182);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', 2123196517, 364869063);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', 1692174491, -1025564911);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', -1529584866, 1196308825);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('c_s_ff229f', 1442655647, -87647544);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('c_s_ff229f', 1296)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/