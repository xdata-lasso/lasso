-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'Bob', 'A', 'City1', 40);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, 'Alice', 'B', 'City2', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, home_city, age FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('Alice', 'City2', 30)
('Bob', 'City1', 40)
*/

-- Prediction Query
SELECT name, home_city, age FROM driver;

/*
Prediction Result:
('Bob', 'City1', 40)
('Alice', 'City2', 30)
*/