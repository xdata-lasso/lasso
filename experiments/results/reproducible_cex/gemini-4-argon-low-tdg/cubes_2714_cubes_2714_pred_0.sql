-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (10, NULL, 'Dem', 'Denver', 50);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, NULL, NULL, NULL, NULL);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Zack', 'Rep', 'Miami', 22);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Aaron', 'Ind', 'Seattle', 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, home_city, age FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
(None, None, None)
(None, 'Denver', 50)
('Aaron', 'Seattle', 60)
('Zack', 'Miami', 22)
*/

-- Prediction Query
SELECT name, home_city, age FROM driver;

/*
Prediction Result:
('Zack', 'Miami', 22)
('Aaron', 'Seattle', 60)
(None, None, None)
(None, 'Denver', 50)
*/