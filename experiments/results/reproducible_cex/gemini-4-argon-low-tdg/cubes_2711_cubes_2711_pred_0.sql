-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Inner join filtering (unmatched drivers and schools), duplicate output rows (DISTINCT vs ALL), and basic multi-column sorting.
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Alice', 'Dem', 'NY', 30);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Alice', 'Rep', 'LA', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Bob', 'Ind', 'SF', 50);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'UnmatchedDriver', 'Dem', 'CHI', 25);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (10, 'K-12', 'Alpha High', 'NY', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (20, '9-12', 'Alpha High', 'LA', 'Private');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (30, 'K-5', 'Beta Elem', 'SF', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (40, '6-8', 'UnmatchedSchool', 'BOS', 'Private');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 1, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (20, 2, 0, 0);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 3, 10, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (30, 1, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, name FROM (SELECT LHS.driver_id AS driver_id, LHS.name AS name, LHS.party AS party, LHS.home_city AS home_city, LHS.age AS age, LHS.school_id AS school_id, LHS.grade AS grade, LHS.school AS school, LHS.location AS LOCATION, LHS.type AS TYPE, RHS.years_working AS years_working, RHS.if_full_time AS if_full_time FROM (SELECT LHS.driver_id AS driver_id, LHS.name AS name, LHS.party AS party, LHS.home_city AS home_city, LHS.age AS age, RHS.school_id AS school_id, RHS.grade AS grade, RHS.school AS school, RHS.location AS LOCATION, RHS.type AS TYPE FROM driver AS LHS CROSS JOIN school AS RHS) AS LHS INNER JOIN school_bus AS RHS ON (LHS.driver_id = RHS.driver_id AND LHS.school_id = RHS.school_id)) ORDER BY school, name NULLS LAST;

/*
Gold Result:
('Alpha High', 'Alice')
('Alpha High', 'Alice')
('Alpha High', 'Bob')
('Beta Elem', 'Alice')
*/

-- Prediction Query
SELECT T2.school, T3.name FROM school_bus AS T1 JOIN school AS T2 ON T1.school_id = T2.school_id JOIN driver AS T3 ON T1.driver_id = T3.driver_id;

/*
Prediction Result:
('Alpha High', 'Alice')
('Alpha High', 'Bob')
('Alpha High', 'Alice')
('Beta Elem', 'Alice')
*/