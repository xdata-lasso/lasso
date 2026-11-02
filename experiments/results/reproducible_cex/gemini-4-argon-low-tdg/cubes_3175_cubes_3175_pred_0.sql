-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT vs non-DISTINCT (multiple LHS rows and multiple groups with the same count)
-- 2. ORDER BY ASC vs DESC vs no order (insertion order yields counts 2, 3, 1; sorted is 1, 2, 3)
-- 3. CROSS JOIN vs INNER JOIN on ResID (ResIDs 3, 4, 5 have no entry in Type_Of_Restaurant, yet their group count of 3 must still appear in the output due to CROSS JOIN)
-- 4. Multi-type restaurants (ResID 1 has two types)
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Burger King', '101 Main St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Burger King', '202 Oak Ave', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Subway', '303 Pine Rd', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (4, 'Subway', '404 Maple Dr', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (5, 'Subway', '505 Birch Ln', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (6, 'Taco Bell', '606 Cedar Ct', 2);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (7, 'Wendy''s', '707 Walnut St', 4);
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (10, 'Fast Food', 'Quick service');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (20, 'Diner', 'Casual dining');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (30, 'Unused Type', 'No restaurants');
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (10, 1);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (20, 1);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (10, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT LHS.resid AS resid, LHS.restypeid AS restypeid, LHS.restypename AS restypename, LHS.restypedescription AS restypedescription, RHS.resname AS resname, RHS.n AS n FROM (SELECT LHS.resid AS resid, LHS.restypeid AS restypeid, RHS.restypename AS restypename, RHS.restypedescription AS restypedescription FROM type_of_restaurant AS LHS INNER JOIN restaurant_type AS RHS ON (LHS.restypeid = RHS.restypeid)) AS LHS CROSS JOIN (SELECT resname, COUNT(*) AS n FROM restaurant GROUP BY resname) AS RHS) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Restaurant JOIN Type_Of_Restaurant ON Restaurant.ResID = Type_Of_Restaurant.ResID JOIN Restaurant_Type ON Type_Of_Restaurant.ResTypeID = Restaurant_Type.ResTypeID GROUP BY Type_Of_Restaurant.ResTypeID HAVING Restaurant_Type.ResTypeName = 'Sandwich';

/*
Prediction Result:
*/