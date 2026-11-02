-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (1, 'Zesty Grill', '10 First St', 1);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (2, 'Midway Diner', '20 Second St', 3);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (3, 'Alpha Bistro', '30 Third St', 5);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'NYC');
INSERT INTO Restaurant_Type (ResTypeID, ResTypeName, ResTypeDescription) VALUES (1, 'Diner', 'Casual dining');
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 1);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 2);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 101, '2023-01-10 12:00:00', 15.50);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (2, 101, '2023-01-11 18:30:00', 22.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname_other AS resname, rating_other AS rating FROM (SELECT LHS.resid AS resid, LHS.resname AS resname, LHS.address AS address, LHS.rating AS rating, RHS.resid AS resid_other, RHS.resname AS resname_other, RHS.address AS address_other, RHS.rating AS rating_other FROM restaurant AS LHS CROSS JOIN restaurant AS RHS) WHERE (rating < rating_other) ORDER BY resname, rating NULLS LAST;

/*
Gold Result:
('Alpha Bistro', 5)
('Alpha Bistro', 5)
('Midway Diner', 3)
*/

-- Prediction Query
SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC, Restaurant.resid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha Bistro', 5)
*/