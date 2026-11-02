-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: wrestler --
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

-- Inserting into table: elimination --
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_1', '-2147483648', 'eli_cadb2f', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_2', '-2147483648', 'eli_cadb2f', 'n', 'rmdp', 'siie');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_3', '-2147483648', 'eli_cadb2f', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_4', '-2147483648', 'eli_cadb2f', 'u', '4nrq', 'rofqyp5s5b');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_5', '-2147483648', 'eli_cadb2f', '02eu', 'liqa1', 'ryytoo3');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_6', '-2147483648', 'eli_cadb2f', 'hl72klex1', 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_7', '-2147483648', 'eli_cadb2f', '9rljsl0b4', 'p5qi2rk', '9v');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_8', '-2147483648', 'eli_cadb2f', 'x58pz0f8je', 'd2', 'vy9uxj4');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminatio_9', '-2147483648', 'eli_cadb2f', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminati_10', '-2147483648', NULL, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminati_11', '-2147483648', NULL, 'kn6vck6ah0f8', 'sww', 'q7x');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminati_12', '-2147483648', NULL, '72fxa7ryfd', 'z16ni', 'jai');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminati_13', '-2147483648', 'eli_cadb2f', 'h', 'ogrgjd8y', 't1afgog');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminati_14', '-2147483648', 'eli_cadb2f', 'tsj', 'ayxp1q43', '1jh3den');

INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('eliminati_15', '-2147483648', 'eli_cadb2f', '68x8vacx7a', 'u5', '1of77p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT team, COUNT(*) AS n FROM elimination GROUP BY team) WHERE (n >= 3) ORDER BY team;

/*
Gold Result:
(None,)
('eli_cadb2f',)
*/

-- Prediction Query
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*) > 3;

/*
Prediction Result:
('eli_cadb2f',)
*/