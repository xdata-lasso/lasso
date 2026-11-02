-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1006, 'Kimberly Dudley', '283 Steven Groves
Lake Mark, WI 07832', 1007);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1008, 'Andrew Stewart', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname FROM restaurant ORDER BY resname, restaurant.resid NULLS LAST;

/*
Gold Result:
('Andrew Stewart',)
('Kimberly Dudley',)
*/

-- Prediction Query
SELECT ResName FROM Restaurant;

/*
Prediction Result:
('Kimberly Dudley',)
('Andrew Stewart',)
*/