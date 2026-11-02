-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: wrestler --
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1, 'wre_34fc16', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (2, 'wre_34fc16', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (3, 'wre_34fc16', 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-1, 'wre_34fc16', 'a9000t5c4eci', '@', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (4, NULL, '5k5swwqcgs', '9n8', '4', 'gu7v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('wre_34fc16',)
*/