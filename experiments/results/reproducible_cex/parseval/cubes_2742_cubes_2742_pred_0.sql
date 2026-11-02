-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: faculty --
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (2, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (3, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (4, 'value', 'fac_e9656c', NULL, 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (5, 'value', 'fac_e9656c', NULL, 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (6, 'value', 'fac_e9656c', NULL, 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (7, 'value', 'fac_e9656c', 'value', NULL, 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (8, 'value', 'fac_e9656c', 'value', NULL, 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (9, 'value', 'fac_e9656c', 'value', NULL, 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (-2147483639, 'fac_7ec0ad', 'fac_e9656c', 'fac_80d96e', '1', -55602865, NULL, 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (-2147483638, 'fac_7ec0ad', 'fac_e9656c', 'fac_80d96e', '1', -59984348, NULL, 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (-2147483637, 'fac_7ec0ad', 'fac_e9656c', 'fac_80d96e', '1', -664303813, NULL, 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (10, NULL, 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (11, NULL, 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (12, NULL, 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (13, 'value', 'fac_e9656c', 'value', 'value', NULL, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (14, 'value', 'fac_e9656c', 'value', 'value', NULL, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (15, 'value', 'fac_e9656c', 'value', 'value', NULL, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (16, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', NULL);

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (17, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', NULL);

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (18, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', NULL);

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (19, 'value', NULL, 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (20, 'value', NULL, 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (21, 'value', NULL, 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (22, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (23, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (24, 'value', 'fac_e9656c', 'value', 'value', 1, 'fac_1076e4', 'value');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (25, 'fac_7ec0ad', 'fac_d8837b', 'fac_80d96e', '1', -1022641847, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (26, 'fac_7ec0ad', 'fac_d8837b', 'fac_80d96e', '1', -1726781632, '24d2f', 'fac_a140e0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT building FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT fname, room, COUNT(*) AS n FROM faculty GROUP BY fname, room) AS RHS ON (LHS.lname = RHS.fname AND LHS.room = RHS.room)) ORDER BY building;

/*
Gold Result:
*/

-- Prediction Query
SELECT building FROM Faculty GROUP BY building ORDER BY COUNT(*) DESC, building NULLS LAST LIMIT 1;

/*
Prediction Result:
('value',)
*/