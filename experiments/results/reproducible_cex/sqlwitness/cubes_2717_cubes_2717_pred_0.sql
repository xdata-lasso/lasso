-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO driver (driver_id, name, party, home_city, age) VALUES (0, NULL, 'Hartford', NULL, 39), (39, 'default1', 'default1', 'default1', 1), (1, NULL, 'default2', 'default1', 1), (41, 'Hartford', 'Hartford', 'default1', NULL), (40, 'default1', NULL, NULL, 41), (2, 'default2', 'Hartford', 'Hartford', 0), (3, NULL, 'default2', NULL, 39), (4, NULL, 'default1', NULL, 41), (5, 'default1', 'Hartford', NULL, 39), (6, 'Hartford', 'default2', 'default1', 1), (7, 'default1', 'default1', 'default2', 41), (8, 'default1', 'default2', 'default2', 39), (9, NULL, NULL, 'default2', 40), (10, 'default1', 'Hartford', 'default1', 1), (11, NULL, 'Hartford', 'default2', 1), (12, 'default1', 'default2', 'Hartford', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "driver" WHERE ("home_city" = 'Hartford' AND age < 40) ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM driver WHERE home_city = 'Hartford' AND age < 40;

/*
Prediction Result:
('default2',)
('default1',)
*/