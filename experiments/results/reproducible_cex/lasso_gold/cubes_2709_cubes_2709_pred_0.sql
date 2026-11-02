-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1006, 'Kristina Baldwin', 'collection', 'Robinsonshire', 1007);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1008, 'Sean Blake', 'science', 'Port Matthew', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT home_city FROM driver ORDER BY home_city;

/*
Gold Result:
('Port Matthew',)
('Robinsonshire',)
*/

-- Prediction Query
SELECT DISTINCT home_city FROM driver;

/*
Prediction Result:
('Robinsonshire',)
('Port Matthew',)
*/