-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, grade, school, location, type) VALUES (1, 'default2', 'default1', NULL, 'default1'), (0, 'default1', 'default2', 'default2', 'default2');
INSERT INTO driver (driver_id, name, party, home_city, age) VALUES (0, NULL, 'default2', 'default1', 1), (1, 'default2', NULL, NULL, NULL), (2, 'default2', 'default1', NULL, NULL), (3, 'default2', 'default1', 'default1', 1), (4, 'default1', 'default1', NULL, NULL);
INSERT INTO school_bus (school_id, driver_id, years_working, if_full_time) VALUES (0, 3, 0, NULL), (1, 3, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, name FROM (SELECT LHS.driver_id AS driver_id, LHS.name AS name, LHS.party AS party, LHS.home_city AS home_city, LHS.age AS age, LHS.school_id AS school_id, LHS.grade AS grade, LHS.school AS school, LHS.location AS LOCATION, LHS.type AS TYPE, RHS.years_working AS years_working, RHS.if_full_time AS if_full_time FROM (SELECT LHS.driver_id AS driver_id, LHS.name AS name, LHS.party AS party, LHS.home_city AS home_city, LHS.age AS age, RHS.school_id AS school_id, RHS.grade AS grade, RHS.school AS school, RHS.location AS LOCATION, RHS.type AS TYPE FROM driver AS LHS CROSS JOIN school AS RHS) AS LHS INNER JOIN school_bus AS RHS ON (LHS.driver_id = RHS.driver_id AND LHS.school_id = RHS.school_id)) ORDER BY school, name NULLS LAST;

/*
Gold Result:
('default1', 'default2')
('default2', 'default2')
*/

-- Prediction Query
SELECT T2.school, T3.name FROM school_bus AS T1 JOIN school AS T2 ON T1.school_id = T2.school_id JOIN driver AS T3 ON T1.driver_id = T3.driver_id;

/*
Prediction Result:
('default2', 'default2')
('default1', 'default2')
*/