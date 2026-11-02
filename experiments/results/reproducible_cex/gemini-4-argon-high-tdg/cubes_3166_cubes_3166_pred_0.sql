-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Doe', 'Jane', 22, 'F', 600, 1121, 'LAX');
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (10, 'Subway', '123 Main St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (20, 'Burger King', '456 Oak Ave', 3);
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Sandwich', 'Z_Quick sandwiches');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (2, 'Burger', 'M_Grilled burgers');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (3, 'Pizza', 'A_Italian pizza');
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 10);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 20);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (2, 20);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (10, 101, '2023-05-01 12:00:00', 15.50);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (10, 102, '2023-05-02 13:00:00', 12.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT restypename FROM restaurant_type ORDER BY restypename, restaurant_type.restypeid NULLS LAST;

/*
Gold Result:
('Burger',)
('Pizza',)
('Sandwich',)
*/

-- Prediction Query
SELECT ResTypeName FROM Restaurant_Type;

/*
Prediction Result:
('Sandwich',)
('Burger',)
('Pizza',)
*/