-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: driver --
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1, 'dri_ea293d', 'dri_968dbf', 'dri_25e9c6', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483647, 'dri_073e1a', 'dri_723c23', 'dri_d7a630', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483646, '5k5swwqcgs', '9n8', 'q_2_4d1754', 1610062532);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483645, 'pgu7vfe4', 'hria2ypuzhs', 'q_2_4d1754', 700293388);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483644, 'wbbp6luhvdlt', 'ilbnp', 'q_2_4d1754', 1236688122);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (2, 'dpos', 'ie5', 'nw6klf', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (4, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (3, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483640, 'l7', 'klex14ji', 'q_2_4d1754', -453362185);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483639, 'au2dwyrq13', 'yu78', 'q_2_4d1754', 244829661);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (-2147483638, 'jsl', 'b4yp5qi', 'q_2_4d1754', -227162283);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (5, 'f9v', 'x58pz', 'f8jegd2', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (7, 'vy9uxj4', 'wb', 'v', 40);

INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (6, 'ph2', 'nd', 'wnqcx', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM driver WHERE (age <= 40)) ORDER BY home_city) LIMIT 3);

/*
Gold Result:
('dri_25e9c6',)
('dri_d7a630',)
('f8jegd2',)
*/

-- Prediction Query
SELECT home_city FROM driver EXCEPT SELECT home_city FROM driver WHERE age > 40;

/*
Prediction Result:
('dri_25e9c6',)
('dri_d7a630',)
('f8jegd2',)
('nw6klf',)
('v',)
('wnqcx',)
('ytoo3o9',)
('zbuo4nrqrof',)
*/