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
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Fast Food', 'Quick service');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (2, 'Diner', 'Casual dining');
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Charlie Grill', '999 Zeta Ave', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Alpha Cafe', '500 Mid St', 1);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Bravo Bistro', '100 First Ave', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (4, 'Alpha Cafe', '200 Second Ave', 4);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 1);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (2, 1);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 2);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 101, '2023-01-10 12:00:00', 15.50);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 102, '2023-01-11 13:00:00', 25.00);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 101, '2023-01-12 18:30:00', 10.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname FROM restaurant ORDER BY resname, restaurant.resid NULLS LAST;

/*
Gold Result:
('Alpha Cafe',)
('Alpha Cafe',)
('Bravo Bistro',)
('Charlie Grill',)
*/

-- Prediction Query
SELECT ResName FROM Restaurant;

/*
Prediction Result:
('Charlie Grill',)
('Alpha Cafe',)
('Bravo Bistro',)
('Alpha Cafe',)
*/