-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (11, '20', '21', 22, '23', 17, 1121, '24');
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (10, '1', '1', 1, '1', 16, 15, '1');
INSERT INTO "Restaurant" ("resid", "resname", "address", "rating") VALUES (13, '1', '1', 1);
INSERT INTO "Restaurant" ("resid", "resname", "address", "rating") VALUES (12, '1', '1', 1);
INSERT INTO "Type_Of_Restaurant" ("restypeid", "resid") VALUES (14, 12);
INSERT INTO "Type_Of_Restaurant" ("restypeid", "resid") VALUES (14, 13);
INSERT INTO "Restaurant_Type" ("restypeid", "restypename", "restypedescription") VALUES (14, '1', '1');
INSERT INTO "Visits_Restaurant" ("resid", "stuid", "time", "spent") VALUES (13, 10, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT advisor, major, COUNT(*) AS n FROM student GROUP BY advisor, major) WHERE (advisor = 1121 OR n > 1121) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE Advisor = 1121;

/*
Prediction Result:
(1,)
*/