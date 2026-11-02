-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests column confusion (ResTypeName vs ResTypeDescription vs ResName) and out-of-order insertion to catch missing ORDER BY clauses.
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (100, 'Alpha', '123 Road', 5);
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Zebra', 'Apple');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (2, 'Mango', 'Banana');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (3, 'Apple', 'Zebra');
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 100);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (2, 100);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (3, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT restypename FROM restaurant_type ORDER BY restypename, restaurant_type.restypeid NULLS LAST;

/*
Gold Result:
('Apple',)
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT ResTypeName FROM Restaurant_Type;

/*
Prediction Result:
('Zebra',)
('Mango',)
('Apple',)
*/