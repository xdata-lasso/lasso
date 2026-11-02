-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'Alice Smith', 'Republican', 'Hartford', 45);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, 'Bob Jones', 'Democrat', 'Hartford', 41);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (3, 'Charlie Brown', 'Independent', 'Hartford', 40);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (4, 'Diana Prince', 'Green', 'Hartford', 35);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (5, 'Evan Wright', 'Libertarian', 'New Haven', 50);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (6, 'Frank Miller', 'Democrat', 'Hartford', 55);
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (101, 'High', 'Central High', 'Hartford', 'Public');
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (102, 'Middle', 'West Middle', 'New Haven', 'Private');
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (101, 1, 10, 1);
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (101, 3, 5, 0);
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (101, 5, 45, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "party" FROM "driver" WHERE ("home_city" = 'Hartford' AND age > 40) ORDER BY party, driver.driver_id NULLS LAST;

/*
Gold Result:
('Democrat',)
('Democrat',)
('Republican',)
*/

-- Prediction Query
SELECT party FROM driver WHERE home_city = 'Hartford' AND age > 40;

/*
Prediction Result:
('Republican',)
('Democrat',)
('Democrat',)
*/