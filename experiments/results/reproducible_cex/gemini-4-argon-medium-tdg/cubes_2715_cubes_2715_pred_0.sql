-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Alice', 'Dem', 'NY', 35);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Bob', 'Rep', 'LA', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Charlie', 'Ind', 'SF', 28);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (1, 'High', 'Oak Ridge', 'North', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (2, 'Middle', 'Pine Crest', 'South', 'Private');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (3, 'Elementary', 'Maple Leaf', 'East', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (4, 'High', ' Maple Leaf', 'West', 'Charter');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (5, 'High', 'Cedar Grove', 'Center', 'Public');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (1, 1, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (1, 2, 2, 0);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (2, 1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, TYPE FROM (SELECT * FROM school AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.school_id = RHS.school_id))) ORDER BY school, TYPE NULLS LAST;

/*
Gold Result:
(' Maple Leaf', 'Charter')
('Cedar Grove', 'Public')
('Maple Leaf', 'Public')
*/

-- Prediction Query
SELECT school, TYPE FROM school WHERE NOT school_id IN (SELECT school_id FROM school_bus);

/*
Prediction Result:
('Maple Leaf', 'Public')
(' Maple Leaf', 'Charter')
('Cedar Grove', 'Public')
*/