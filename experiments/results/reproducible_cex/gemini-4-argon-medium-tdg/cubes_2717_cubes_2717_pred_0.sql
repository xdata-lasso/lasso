-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate Names (SELECT vs SELECT DISTINCT), ordering by Name (ASC vs DESC), and NULL handling in columns.
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (10, 'Zack', 'Dem', 'Hartford', 30);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (20, 'Aaron', 'Rep', 'Hartford', 25);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (15, 'Aaron', 'Ind', 'Hartford', 35);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (30, NULL, 'Dem', 'Hartford', 28);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (40, 'Grace', 'Rep', NULL, 22);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (50, 'Heidi', 'Dem', 'Hartford', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "driver" WHERE ("home_city" = 'Hartford' AND age < 40) ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM driver WHERE home_city = 'Hartford' AND age < 40;

/*
Prediction Result:
('Zack',)
('Aaron',)
('Aaron',)
(None,)
*/