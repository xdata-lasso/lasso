-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Zack', 'Dem', 'Boston', 50);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Alice', 'Rep', 'Chicago', 25);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Bob', 'Ind', 'Austin', 35);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'Charlie', 'Dem', 'Boston', 40);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (10, '12', 'Central High', 'Denver', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (20, '6', 'West Middle', 'Seattle', 'Private');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 1, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (20, 1, 2, 0);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 2, 8, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT home_city FROM driver ORDER BY home_city;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT DISTINCT home_city FROM driver;

/*
Prediction Result:
('Boston',)
('Chicago',)
('Austin',)
*/