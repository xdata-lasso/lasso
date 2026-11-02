-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO driver (driver_id, name, party, home_city, age) VALUES (0, 'default1', 'default1', 'default2', NULL), (1, 'default2', NULL, 'default2', 0), (2, 'default2', 'default2', 'default1', NULL), (3, 'default2', 'default1', 'default2', NULL), (4, 'default2', 'default2', 'default1', 1), (5, NULL, 'default1', 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT name FROM driver ORDER BY age DESC, driver.driver_id NULLS LAST;

/*
Prediction Result:
('default2',)
(None,)
('default2',)
('default1',)
('default2',)
('default2',)
*/