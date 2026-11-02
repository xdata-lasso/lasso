-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Alice', 'Dem', 'NY', 45);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Bob', 'Rep', 'LA', 38);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (1, 'K-12', 'Alpha High', 'NY', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (2, 'K-12', 'Alpha High', 'LA', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (3, '9-12', 'Beta Prep', 'SF', 'Private');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (4, '9-12', 'Beta Prep', 'TX', 'Charter');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (5, '9-12', 'Beta Prep', 'FL', NULL);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (6, 'K-5', 'Gamma Elem', 'WA', 'Public');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (7, '6-8', 'Delta Mid', 'OR', 'Private');
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (8, 'K-8', NULL, 'NV', 'Public');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (6, 1, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (6, 2, 3, 0);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (7, 1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, TYPE FROM (SELECT * FROM school AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.school_id = RHS.school_id))) ORDER BY school, TYPE NULLS LAST;

/*
Gold Result:
(None, 'Public')
('Alpha High', 'Public')
('Alpha High', 'Public')
('Beta Prep', 'Charter')
('Beta Prep', 'Private')
('Beta Prep', None)
*/

-- Prediction Query
SELECT school, TYPE FROM school WHERE NOT school_id IN (SELECT school_id FROM school_bus);

/*
Prediction Result:
('Alpha High', 'Public')
('Alpha High', 'Public')
('Beta Prep', 'Private')
('Beta Prep', 'Charter')
('Beta Prep', None)
(None, 'Public')
*/