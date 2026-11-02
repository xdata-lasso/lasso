-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (101, 'Alpha', '10 First St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (102, 'Alpha', '20 Second St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (103, 'Alpha', '30 Third St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (104, 'Beta', '40 Fourth St', 2);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (105, 'Beta', '50 Fifth St', 1);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (106, 'Delta', '60 Sixth St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (107, 'Gamma', '70 Seventh St', 4);
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (201, 'Fast Food', 'Quick service meals');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (202, 'Diner', 'Casual sit-down dining');
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (201, 107);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (202, 107);
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