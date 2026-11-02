-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: driver --
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1, 'dri_78f6a0', '5k5swwqcgs', '9n8', 1610062532);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483647, 'dri_78f6a0', 'pgu7vfe4', 'hria2ypuzhs', 700293388);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (2, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', -1576219117);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (3, '5u', 'w6kl', 'a9', 1620389964);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (4, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 373262291);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (5, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', -1666765085);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (6, '72klex14ji7z', 'au2dwy', 'q13py', 244829661);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (7, 'jsl', 'b4yp5qi', 'rkf9vqx5', 1836127587);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (8, 'f8jegd2', 'vy9uxj4', 'wb', -1929953647);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (9, 'ph2', 'nd', 'wnqcx', 722884590);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (10, 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 172461907);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (11, 'k3zbily', 'kn6vc', '6ah', -348113485);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT LHS.name AS name, LHS.n AS n, RHS.party AS party, RHS.home_city AS home_city, RHS.age AS age FROM (SELECT name, COUNT(*) AS n FROM driver GROUP BY name) AS LHS INNER JOIN driver AS RHS ON (LHS.n = RHS.driver_id AND LHS.name = RHS.name)) ORDER BY home_city;

/*
Gold Result:
*/

-- Prediction Query
SELECT home_city FROM driver GROUP BY home_city ORDER BY COUNT(*) DESC, home_city NULLS LAST LIMIT 1;

/*
Prediction Result:
('6ah',)
*/