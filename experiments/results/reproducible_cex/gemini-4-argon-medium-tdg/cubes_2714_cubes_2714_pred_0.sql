-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Driver_ID, and detects erroneous INNER JOINs with school_bus (missing drivers) or duplicate rows from 1-to-many relationships.
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (3, 'Alice', 'Dem', 'Seattle', 35);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'Alice', 'Rep', 'Austin', 40);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, 'Bob', 'Dem', 'Boston', 25);
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (10, 'High', 'West High', 'Austin', 'Public');
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (20, 'Middle', 'East Middle', 'Seattle', 'Private');
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (10, 1, 5, 1);
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (20, 1, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, home_city, age FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('Alice', 'Austin', 40)
('Alice', 'Seattle', 35)
('Bob', 'Boston', 25)
*/

-- Prediction Query
SELECT name, home_city, age FROM driver;

/*
Prediction Result:
('Alice', 'Austin', 40)
('Bob', 'Boston', 25)
('Alice', 'Seattle', 35)
*/