-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: driver --
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1, 'dri_05512e', 'dri_7232f3', 'dri_8a27d6', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483647, 'dri_c36dfc', 'dri_2a05bf', 'dri_db4092', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (2, '5k5swwqcgs', '9n8', '4', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (3, 'gu7v', 'e4', 'hria2ypuzhs', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483644, 'rwbbp6luhvd', 'tti', 'q_1_6b62c0', -1364429300);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483643, 'nprmdposii', '5u', 'q_1_6b62c0', 1861536320);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT home_city, party, COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM driver WHERE (age = 40 AND age >= 2)) GROUP BY home_city, party) ORDER BY home_city;

/*
Gold Result:
('4',)
('dri_8a27d6',)
('dri_db4092',)
('hria2ypuzhs',)
*/

-- Prediction Query
SELECT home_city FROM driver WHERE age > 40 GROUP BY home_city HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/