-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Zoe', 'Dem', 'Hartford', 39);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Alice', 'Rep', 'Hartford', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Bob', 'Dem', 'Hartford', 45);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'Charlie', 'Ind', 'Boston', 25);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, 'David', 'Rep', 'Boston', 50);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (6, 'Aaron', 'Ind', 'Hartford', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "driver" WHERE ("home_city" = 'Hartford' AND age < 40) ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('Aaron',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM driver WHERE home_city = 'Hartford' AND age < 40;

/*
Prediction Result:
('Zoe',)
('Aaron',)
*/