-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of insertion order), duplicate Names (kills SELECT DISTINCT mutants), and drivers without school_bus records (kills inner join mutants).
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'Charlie', 'Democrat', 'Austin', 45);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, 'Alice', 'Republican', 'Dallas', 30);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (3, 'Bob', 'Independent', 'Houston', 50);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (4, 'Alice', 'Democrat', 'Austin', 25);
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (10, 'High', 'Westlake', 'Austin', 'Public');
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (10, 1, 5, 1);
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (10, 2, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM driver ORDER BY age DESC, driver.driver_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Charlie',)
('Alice',)
('Alice',)
*/