-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO driver (driver_id, name, party, home_city, age) VALUES (1, 'default2', NULL, 'default2', 0), (0, 'default1', 'default1', 'default1', NULL), (2, 'default1', 'default2', 'default1', 0), (3, 'default1', NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, home_city, age FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('default1', 'default1', None)
('default1', 'default1', 0)
('default1', 'default1', None)
('default2', 'default2', 0)
*/

-- Prediction Query
SELECT name, home_city, age FROM driver;

/*
Prediction Result:
('default1', 'default1', None)
('default2', 'default2', 0)
('default1', 'default1', 0)
('default1', 'default1', None)
*/