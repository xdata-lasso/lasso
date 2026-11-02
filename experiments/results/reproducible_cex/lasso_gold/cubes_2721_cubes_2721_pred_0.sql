-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1016, 'Mark Diaz', 'hospital', 'Jasonview', 1017);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1018, 'James Mayo', 'prove', 'New Jessica', 1018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM driver AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.driver_id = RHS.driver_id))) ORDER BY name;

/*
Gold Result:
('James Mayo',)
('Mark Diaz',)
*/

-- Prediction Query
SELECT name FROM driver WHERE NOT driver_id IN (SELECT driver_id FROM school_bus);

/*
Prediction Result:
('Mark Diaz',)
('James Mayo',)
*/