-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1001, 'Allison Hill', '863 Lawrence Valleys
Port Lindachester, MA 36922', 1005);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1002, 'Noah Rhodes', '16155 Roman Stream Suite 816
New Kellystad, OK 25704', 1014.0);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1003, 'Angie Henderson', '341 Michelle Light
Shawnstad, GA 49021', 1023.0);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1004, 'Daniel Wagner', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 1032.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname, rating FROM (SELECT * FROM (SELECT * FROM restaurant ORDER BY address, restaurant.resid NULLS LAST) LIMIT 1);

/*
Gold Result:
('Noah Rhodes', 1014)
*/

-- Prediction Query
SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC, Restaurant.resid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner', 1032)
*/