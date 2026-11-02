-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant_type" ("restypeid", "restypename", "restypedescription") VALUES (1004, 'Melissa Peterson', 'Democratic shake bill here.');
INSERT INTO "restaurant_type" ("restypeid", "restypename", "restypedescription") VALUES (1005, 'Juan Calderon', 'Role movie win.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT restypename FROM restaurant_type ORDER BY restypename, restaurant_type.restypeid NULLS LAST;

/*
Gold Result:
('Juan Calderon',)
('Melissa Peterson',)
*/

-- Prediction Query
SELECT ResTypeName FROM Restaurant_Type;

/*
Prediction Result:
('Melissa Peterson',)
('Juan Calderon',)
*/