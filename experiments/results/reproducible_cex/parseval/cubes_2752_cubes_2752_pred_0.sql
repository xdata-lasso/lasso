-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("actid", "activity_name") VALUES (1, 'A');

INSERT INTO "activity" ("actid", "activity_name") VALUES (2, 'A');

INSERT INTO "activity" ("actid", "activity_name") VALUES (3, 'act_0b869c');

-- Inserting into table: faculty --
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1, 'rhs_cf940d', 'rhs_42d9d1', 'rhs_c8cb7b', 'rhs_13b2a4', 1, 'rhs_f7da59', 'rhs_f07d85');

-- Inserting into table: faculty_participates_in --
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (3, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (3, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (3, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (3, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (3, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);

INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "lname" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "LHS"."facid" AS "facid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."rank" AS "rank", "RHS"."sex" AS "sex", "RHS"."phone" AS "phone", "RHS"."room" AS "room", "RHS"."building" AS "building" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "RHS"."facid" AS "facid" FROM "activity" AS "LHS" INNER JOIN "faculty_participates_in" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) AS "LHS" INNER JOIN "faculty" AS "RHS" ON ("LHS"."facid" = "RHS"."facid")) WHERE ("activity_name" = 'Canoeing' OR "activity_name" <> 'Kayaking') ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('rhs_cf940d',)
*/

-- Prediction Query
SELECT T1.lname FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID JOIN activity AS T3 ON T2.actid = T2.actid WHERE T3.activity_name = 'Canoeing' INTERSECT SELECT T1.lname FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID JOIN activity AS T3 ON T2.actid = T2.actid WHERE T3.activity_name = 'Kayaking';

/*
Prediction Result:
*/