-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'Charlie', 'Dem', 'NYC', 45);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, 'Alice', 'Rep', 'LA', 38);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (3, 'Bob', 'Dem', 'Chicago', 50);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (4, 'Alice', 'Ind', 'Boston', 29);
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (1, 'High', 'West High', 'LA', 'Public');
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (2, 'Middle', 'East Middle', 'NYC', 'Private');
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (1, 3, 5, 1);
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (2, 3, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM driver AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.driver_id = RHS.driver_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM driver WHERE NOT driver_id IN (SELECT driver_id FROM school_bus);

/*
Prediction Result:
('Charlie',)
('Alice',)
('Alice',)
*/