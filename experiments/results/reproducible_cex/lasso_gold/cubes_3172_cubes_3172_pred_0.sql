-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1024, 'Subway', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 1025);
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1026, 'Subway', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 1026);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address" FROM "restaurant" WHERE ("resname" = 'Subway') ORDER BY address, restaurant.resid NULLS LAST;

/*
Gold Result:
('76311 Gomez Loop Suite 010\nChandlerville, IA 25613',)
('83465 Lam Mission Apt. 331\nAndrewside, IN 77629',)
*/

-- Prediction Query
SELECT Address FROM Restaurant WHERE ResName = 'Subway';

/*
Prediction Result:
('83465 Lam Mission Apt. 331\nAndrewside, IN 77629',)
('76311 Gomez Loop Suite 010\nChandlerville, IA 25613',)
*/