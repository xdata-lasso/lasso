-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (1, 'John', 'Dem', 'Hartford', 40);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (2, 'Jane', 'Rep', 'Hartford', 39);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (3, 'Bob', 'Dem', 'Hartford', 41);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (4, 'Alice', 'Ind', 'Boston', 40);
INSERT INTO "driver" ("Driver_ID", "Name", "Party", "Home_city", "Age") VALUES (5, 'Charlie', 'Rep', 'New York', 50);
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (1, 'High', 'Central', 'Hartford', 'Public');
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (1, 1, 5, 1);
INSERT INTO "school_bus" ("School_ID", "Driver_ID", "Years_Working", "If_full_time") VALUES (1, 2, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM "driver" WHERE ("home_city" <> 'Hartford' OR age <> 40) ORDER BY count___;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM driver WHERE home_city = 'Hartford' OR age < 40;

/*
Prediction Result:
(3,)
*/