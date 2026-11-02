-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in WHERE predicates (Age is NULL, Home_city is NULL) and in SELECT / ORDER BY (Name is NULL)
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'Zack', 'Dem', 'Hartford', 25);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, NULL, 'Rep', 'Hartford', 30);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (3, 'Aaron', 'Ind', 'Hartford', 35);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (4, 'Grace', 'Dem', NULL, 28);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (5, 'Heidi', 'Rep', 'Hartford', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "driver" WHERE ("home_city" = 'Hartford' AND age < 40) ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM driver WHERE home_city = 'Hartford' AND age < 40;

/*
Prediction Result:
('Zack',)
(None,)
('Aaron',)
*/