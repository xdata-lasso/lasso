-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (101, 'Alice Smith', 'Dem', 'Springfield', 45);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (102, 'Bob Jones', 'Rep', 'Shelbyville', 52);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (1, '9-12', 'Oak High', 'Northside', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (2, 'K-5', 'Pine Elem', 'Westside', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (3, '6-8', 'Maple Mid', 'Eastside', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (4, '6-8', 'Maple Mid', 'Southside', 'Charter');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (5, '9-12', 'Cedar High', 'Downtown', 'Private');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (1, 101, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (1, 102, 3, 0);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (5, 101, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, TYPE FROM (SELECT * FROM school AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.school_id = RHS.school_id))) ORDER BY school, TYPE NULLS LAST;

/*
Gold Result:
('Maple Mid', 'Charter')
('Maple Mid', 'Public')
('Pine Elem', 'Public')
*/

-- Prediction Query
SELECT school, TYPE FROM school WHERE NOT school_id IN (SELECT school_id FROM school_bus);

/*
Prediction Result:
('Pine Elem', 'Public')
('Maple Mid', 'Public')
('Maple Mid', 'Charter')
*/