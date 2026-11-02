-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, grade, school, location, type) VALUES (2, 'default1', 'default1', NULL, NULL), (1, 'default1', 'default2', 'default2', NULL), (0, 'default1', 'default2', NULL, 'default2');
INSERT INTO driver (driver_id, name, party, home_city, age) VALUES (0, 'default2', 'default1', 'default2', 1), (1, 'default1', 'default2', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM driver AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.driver_id = RHS.driver_id))) ORDER BY name;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM driver WHERE NOT driver_id IN (SELECT driver_id FROM school_bus);

/*
Prediction Result:
('default2',)
('default1',)
*/