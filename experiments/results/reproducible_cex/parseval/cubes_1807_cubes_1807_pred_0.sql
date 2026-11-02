-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: wrestler --
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1, 'wre_c6bff8', 'wre_65759e', '5k5swwqcgs', 'wre_2be4ac', 'wre_73883d');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (2, 'lhs_6f2295', 'lhs_8ea62c', 'lhs_390dd0', 'lhs_326831', 'lhs_fc6b95');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (3, 'lhs_bbcb9f', 'lhs_8ea62c', 'lhs_03e062', 'lhs_6877f1', 'lhs_6c22ee');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (4, '9n8', 'lhs_c813c9', '4', 'gu7v', 'e4');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (5, 'hria2ypuzhs', 'rwbbp6luhvd', 'lhs_c813c9', 'tti', 'bnp');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (6, 'mdpos', 'lhs_c813c9', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (7, 'gce376nium52', 'zbuo4nrqrof', 'lhs_c813c9', 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (8, 'ytoo3o9', 'lhs_c813c9', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (9, '13pyu', '8d99rljsl', 'lhs_c813c9', 'b4yp5qi', 'rkf9vqx5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.wrestler_id AS wrestler_id, LHS.name AS name, LHS.reign AS reign, LHS.days_held AS days_held, LHS.location AS LOCATION, LHS.event AS event, RHS.wrestler_id AS wrestler_id_other, RHS.name AS name_other, RHS.reign AS reign_other, RHS.location AS location_other, RHS.event AS event_other FROM wrestler AS LHS INNER JOIN wrestler AS RHS ON (LHS.reign = RHS.days_held)) ORDER BY name;

/*
Gold Result:
('13pyu',)
('gce376nium52',)
('hria2ypuzhs',)
*/

-- Prediction Query
SELECT Name FROM wrestler WHERE Days_held < 100;

/*
Prediction Result:
*/