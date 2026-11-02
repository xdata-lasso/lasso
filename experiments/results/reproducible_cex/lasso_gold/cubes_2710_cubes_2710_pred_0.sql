-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1018, 'Mark Diaz', 'hospital', 'Jasonview', 100);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1020, 'Mark Diaz', 'prove', 'New Jessica', -50);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1022, 'Amy Underwood', 'push', 'Lake Mark', 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM driver ORDER BY name, driver.driver_id NULLS LAST;

/*
Gold Result:
('Amy Underwood',)
('Mark Diaz',)
('Mark Diaz',)
*/

-- Prediction Query
SELECT name FROM driver ORDER BY age DESC, driver.driver_id NULLS LAST;

/*
Prediction Result:
('Mark Diaz',)
('Amy Underwood',)
('Mark Diaz',)
*/