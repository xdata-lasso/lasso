-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Subway', 'Zebra Ave', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Subway', 'Alpha St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Subway', 'Alpha St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (4, 'Subway', NULL, 2);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (5, 'subway', 'Lower St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (6, 'Subway ', 'Space St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (7, 'McDonalds', 'Beta St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (8, NULL, 'Gamma St', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address" FROM "restaurant" WHERE ("resname" = 'Subway') ORDER BY address, restaurant.resid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha St',)
('Alpha St',)
('Zebra Ave',)
*/

-- Prediction Query
SELECT Address FROM Restaurant WHERE ResName = 'Subway';

/*
Prediction Result:
('Zebra Ave',)
('Alpha St',)
('Alpha St',)
(None,)
*/