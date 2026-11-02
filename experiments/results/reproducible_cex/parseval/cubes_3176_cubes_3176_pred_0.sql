-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: restaurant --
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1, 'Subway', 'res_d715c9', 1);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483647, 'Subway', 'res_0bdea3', 1);

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'A', 'A', 1, 'stu_0ad83a', 1, 1, 'stu_a36b32');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'A', 'A', 1, 'stu_9d924b', 1, 1, 'stu_ef3d21');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'lhs_edb88a', 'lhs_d786e4', 1, 'lhs_51bb6b', 1, 1, 'lhs_a4c41d');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: visits_restaurant --
INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 2, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 2, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 2, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 2, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, NULL, 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."resname" AS "resname", "RHS"."address" AS "address", "RHS"."rating" AS "rating" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resid" AS "resid", "RHS"."time" AS "time", "RHS"."spent" AS "spent" FROM "student" AS "LHS" INNER JOIN "visits_restaurant" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."lname" = "RHS"."lname" AND "LHS"."fname" = "RHS"."fname" AND "LHS"."age" = "RHS"."age" AND "LHS"."sex" = "RHS"."sex" AND "LHS"."major" = "RHS"."major" AND "LHS"."advisor" = "RHS"."advisor" AND "LHS"."city_code" = "RHS"."city_code")) AS "LHS" INNER JOIN (SELECT * FROM "restaurant" WHERE ("resname" = 'Subway')) AS RHS ON (LHS.resid = RHS.resid)) ORDER BY TIME, "time" NULLS LAST;

/*
Gold Result:
(None,)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
*/

-- Prediction Query
SELECT TIME FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID JOIN Restaurant ON Visits_Restaurant.ResID = Restaurant.ResID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith' AND Restaurant.ResName = 'Subway';

/*
Prediction Result:
*/