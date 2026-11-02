-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: representative --
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483648, 'rep_359ffd', '5k5swwqcgs', 'rep_edb4cf', '9n8');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483647, 'rep_359ffd', '4', 'rep_edb4cf', 'gu7v');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483646, 'rep_359ffd', 'e4', 'rep_edb4cf', 'hria2ypuzhs');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483645, 'rep_359ffd', 'rwbbp6luhvd', 'rep_edb4cf', 'tti');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483644, 'rep_359ffd', 'bnp', 'rep_edb4cf', 'mdpos');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483643, 'rep_359ffd', 'ie5', 'rep_edb4cf', 'nw6klf');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483642, NULL, 'a9000t5c4eci', 'rep_edb4cf', 'gce376nium52');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483641, NULL, 'zbuo4nrqrof', 'rep_edb4cf', 'qyp5s5bbp0');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483640, NULL, '2eutliqa11r', 'rep_edb4cf', 'ytoo3o9');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483639, 'rep_359ffd', 'l7', NULL, 'klex14ji');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483638, 'rep_359ffd', '7zwau2dwyr', NULL, '13pyu');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483637, 'rep_359ffd', '8d99rljsl', NULL, 'b4yp5qi');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483636, 'rep_359ffd', 'rkf9vqx5', 'rep_edb4cf', 'pz0f8jegd');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483635, 'rep_359ffd', '1vy9uxj4', 'rep_edb4cf', 'wb');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483634, 'rep_359ffd', 'v', 'rep_edb4cf', 'ph2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT name, party, COUNT(*) AS n FROM representative GROUP BY name, party) WHERE (n < 3) ORDER BY party;

/*
Gold Result:
*/

-- Prediction Query
SELECT Party FROM representative GROUP BY Party HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None,)
('rep_edb4cf',)
*/