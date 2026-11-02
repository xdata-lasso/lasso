-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (10, 'Subway', '123 Main St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (20, 'Subway', '456 Oak Ave', 2);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (30, 'Subway', '789 Pine Rd', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (40, 'McDonalds', '101 Maple Dr', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (50, 'SubwayX', '202 Birch Ln', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (60, 'subway', '303 Cedar Ct', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rating" FROM "restaurant" WHERE ("resname" = 'Subway') ORDER BY rating, restaurant.resid NULLS LAST;

/*
Gold Result:
(2,)
(5,)
(5,)
*/

-- Prediction Query
SELECT Rating FROM Restaurant WHERE ResName = 'Subway';

/*
Prediction Result:
(5,)
(2,)
(5,)
*/