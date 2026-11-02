-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Alice', 'Dem', 'Boston', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Bob', 'Rep', 'Austin', 41);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Charlie', 'Ind', 'Chicago', 39);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'David', 'Dem', 'Denver', 25);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, 'Eve', 'Rep', 'Seattle', 35);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (6, 'Frank', 'Ind', 'Miami', 50);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (10, 'High', 'Central High', 'Boston', 'Public');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 1, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 2, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM driver WHERE (age <= 40)) ORDER BY home_city) LIMIT 3);

/*
Gold Result:
('Boston',)
('Chicago',)
('Denver',)
*/

-- Prediction Query
SELECT home_city FROM driver EXCEPT SELECT home_city FROM driver WHERE age > 40;

/*
Prediction Result:
('Boston',)
('Chicago',)
('Denver',)
('Seattle',)
*/