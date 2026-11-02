-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Zack', 'Dem', 'NY', 45);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Alice', 'Rep', 'LA', 30);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Charlie', 'Ind', 'SF', 25);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (1, '10th', 'High School A', 'NY', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (2, '5th', 'Elem School B', 'LA', 'Private');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (1, 3, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM driver AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.driver_id = RHS.driver_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM driver WHERE NOT driver_id IN (SELECT driver_id FROM school_bus);

/*
Prediction Result:
('Zack',)
('Alice',)
*/