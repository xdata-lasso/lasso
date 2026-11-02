-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Bistro', '100 Main St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Diner', '200 Oak St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Cafe', '300 Pine St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (4, 'Cafe', '400 Elm St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (5, 'Grill', '500 Maple St', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname_other AS resname, rating_other AS rating FROM (SELECT LHS.resid AS resid, LHS.resname AS resname, LHS.address AS address, LHS.rating AS rating, RHS.resid AS resid_other, RHS.resname AS resname_other, RHS.address AS address_other, RHS.rating AS rating_other FROM restaurant AS LHS CROSS JOIN restaurant AS RHS) WHERE (rating < rating_other) ORDER BY resname, rating NULLS LAST;

/*
Gold Result:
('Cafe', 4)
('Cafe', 4)
('Cafe', 5)
('Cafe', 5)
('Cafe', 5)
*/

-- Prediction Query
SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC, Restaurant.resid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Cafe', 5)
*/