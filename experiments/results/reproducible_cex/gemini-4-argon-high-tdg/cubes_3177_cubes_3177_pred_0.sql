-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Diner', 'Casual dining');
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'City Diner', '45 Oak Ave', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Campus Cafe', '12 College Rd', 3);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 1);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 2);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Linda', 24, 'F', 100, 2001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Smith', 'Linda', 18, 'F', 200, 2002, 'LA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Smith', 'Linda', 20, 'F', 300, 2003, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Smith', 'Linda', 20, 'F', 400, 2004, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Smith', 'Robert', 17, 'M', 100, 2001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Taylor', 'Linda', 29, 'F', 200, 2002, 'SEA');
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 1, '2023-02-01 18:00:00', 12.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 1, '2023-02-02 19:00:00', 25.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 2, '2023-02-03 12:30:00', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM "student" WHERE ("fname" = 'Linda' AND "lname" = 'Smith') ORDER BY age, student.stuid NULLS LAST;

/*
Gold Result:
(18,)
(20,)
(20,)
(24,)
*/

-- Prediction Query
SELECT Age FROM Student WHERE Fname = 'Linda' AND Lname = 'Smith';

/*
Prediction Result:
(24,)
(18,)
(20,)
(20,)
*/