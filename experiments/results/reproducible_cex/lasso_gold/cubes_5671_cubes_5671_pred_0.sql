-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1005, 'Kimberly Dudley', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 1006);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1007, 'Michael Miles', '283 Steven Groves
Lake Mark, WI 07832', 1008);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1009, 'Kimberly Dudley', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 1006);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1010, 'Michael Miles', '283 Steven Groves
Lake Mark, WI 07832', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname_other AS resname, rating_other AS rating FROM (SELECT LHS.resid AS resid, LHS.resname AS resname, LHS.address AS address, LHS.rating AS rating, RHS.resid AS resid_other, RHS.resname AS resname_other, RHS.address AS address_other, RHS.rating AS rating_other FROM restaurant AS LHS CROSS JOIN restaurant AS RHS) WHERE (rating < rating_other) ORDER BY resname, rating NULLS LAST;

/*
Gold Result:
('Michael Miles', 1008)
('Michael Miles', 1008)
('Michael Miles', 1008)
('Michael Miles', 1008)
*/

-- Prediction Query
SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC, Restaurant.resid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Michael Miles', 1008)
*/