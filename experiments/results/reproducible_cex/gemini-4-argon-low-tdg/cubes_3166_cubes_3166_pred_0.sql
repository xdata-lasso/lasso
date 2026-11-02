-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of order insertion), duplicate ResTypeName (to catch DISTINCT mutants),
-- and unreferenced/multiply-referenced Restaurant_Type rows (to catch JOIN Type_Of_Restaurant mutants).
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (101, 'Burger King', '123 Main St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (102, 'Pizza Hut', '456 Oak Ave', 4);
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (3, 'Sandwich', 'Submarine sandwiches');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Burger', 'Fast food burgers');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (2, 'Burger', 'Gourmet burgers');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (4, 'Pizza', 'Italian style pizza');
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 101);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 102);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (2, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT restypename FROM restaurant_type ORDER BY restypename, restaurant_type.restypeid NULLS LAST;

/*
Gold Result:
('Burger',)
('Burger',)
('Pizza',)
('Sandwich',)
*/

-- Prediction Query
SELECT ResTypeName FROM Restaurant_Type;

/*
Prediction Result:
('Burger',)
('Burger',)
('Sandwich',)
('Pizza',)
*/