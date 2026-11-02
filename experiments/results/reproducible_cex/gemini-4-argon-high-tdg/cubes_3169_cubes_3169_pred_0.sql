-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 22, 'F', 100, 10, 'LAX');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Fast Food', 'Quick service');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (2, 'Sandwich', 'Submarine sandwiches');
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Subway', '100 Main St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Subway', '200 Oak Ave', 2);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Subway', '300 Pine Rd', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (4, 'McDonalds', 'Subway', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (5, 'subway', '400 Elm St', 1);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (6, 'Subway Express', '500 Maple Dr', 3);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 2);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (2, 2);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 4);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 1, '2023-01-01 12:00:00', 12.50);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 2, '2023-01-02 13:00:00', 15.00);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (4, 1, '2023-01-03 18:00:00', 8.75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rating" FROM "restaurant" WHERE ("resname" = 'Subway') ORDER BY rating, restaurant.resid NULLS LAST;

/*
Gold Result:
(2,)
(5,)
(5,)
*/

-- Prediction Query
SELECT Rating FROM Restaurant WHERE ResName = 'Subway';

/*
Prediction Result:
(5,)
(2,)
(5,)
*/