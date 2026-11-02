-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (30, 'Bob', 'Dem', 'Miami', 25);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (20, 'Alice', 'Rep', 'Boston', 35);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (10, 'Alice', 'Dem', 'Seattle', 45);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, 'Charlie', 'Ind', 'Austin', 20);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (100, 'High', 'Central High', 'Miami', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (200, 'Middle', 'West Middle', 'Boston', 'Private');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (100, 30, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (200, 30, 2, 0);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (100, 20, 8, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, home_city, age FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('Alice', 'Seattle', 45)
('Alice', 'Boston', 35)
('Bob', 'Miami', 25)
('Charlie', 'Austin', 20)
*/

-- Prediction Query
SELECT name, home_city, age FROM driver;

/*
Prediction Result:
('Charlie', 'Austin', 20)
('Alice', 'Seattle', 45)
('Alice', 'Boston', 35)
('Bob', 'Miami', 25)
*/