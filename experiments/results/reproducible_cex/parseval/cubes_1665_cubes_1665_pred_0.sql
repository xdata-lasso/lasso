-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: railway --
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483648, '5k5swwqcgs', 'rai_9a37e0', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483647, 'hria2ypuzhs', 'rai_9a37e0', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483646, 'ie5', 'rai_9a37e0', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483645, 'qyp5s5bbp0', 'rai_9a37e0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483644, '7zwau2dwyr', 'rai_9a37e0', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483643, 'pz0f8jegd', 'rai_9a37e0', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483642, 'nd', 'rai_9a37e0', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483641, 'ozk3zbily', 'rai_9a37e0', 'kn6vc', '6ah', 'f8jswwl', '7xb72');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483640, 'xa', 'rai_9a37e0', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483639, 't1afgog', NULL, 'itsj3', 'y', 'p1q430', 'jh3den8');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483638, 'c68x8vacx7', NULL, 'f', '5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483637, '0v', NULL, 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483636, 'c4bfkfoac', 'rai_9a37e0', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483635, 'dgj5i', 'rai_9a37e0', 'lq5lnpim', 'k58qs27p', 'r94gth2m', 'ajjl');

INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (-2147483634, '3', 'rai_9a37e0', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT builder FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) WHERE (n <> 1) ORDER BY builder;

/*
Gold Result:
(None,)
('rai_9a37e0',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('rai_9a37e0',)
*/