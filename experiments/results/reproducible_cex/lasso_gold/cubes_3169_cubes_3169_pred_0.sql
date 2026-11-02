-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1024, 'Subway', '031 Michele Cliffs
West Elizabeth, IL 71179', 1026);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1026, 'Subway', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 1025);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rating" FROM "restaurant" WHERE ("resname" = 'Subway') ORDER BY rating, restaurant.resid NULLS LAST;

/*
Gold Result:
(1025,)
(1026,)
*/

-- Prediction Query
SELECT Rating FROM Restaurant WHERE ResName = 'Subway';

/*
Prediction Result:
(1026,)
(1025,)
*/