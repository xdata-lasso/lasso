-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'Cena', '1', '50', 'NY', 'WM');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'Cena', '50', '999', 'LA', 'SS');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (3, 'Rock', '2', '100', 'TX', 'RR');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (4, 'Rock', '3', '100', 'TX', 'EC');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (5, 'Rock', '100', '888', 'FL', 'RAW');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (6, 'Orton', '4', '20', 'CA', 'SD');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (7, 'Orton', '20', '777', 'NV', 'NXT');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (8, 'Edge', '5', '20', 'UK', 'SD');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (9, 'Edge', '20', '666', 'CA', 'TLC');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (10, 'Kane', '10', '300', 'NY', 'WM');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (11, 'Taker', '300', '10', 'NY', 'WM');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (12, 'Kane', '99', '300', 'NY', 'WM');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT days_held AS reign FROM (SELECT days_held, event, COUNT(*) AS n FROM (SELECT wrestler_id, name, days_held AS reign, days_held, LOCATION, event, wrestler_id_other, days_held_other, location_other, event_other FROM (SELECT LHS.wrestler_id AS wrestler_id, LHS.name AS name, LHS.reign AS reign, LHS.days_held AS days_held, LHS.location AS LOCATION, LHS.event AS event, RHS.wrestler_id AS wrestler_id_other, RHS.days_held AS days_held_other, RHS.location AS location_other, RHS.event AS event_other FROM wrestler AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign))) GROUP BY days_held, event) ORDER BY reign;

/*
Gold Result:
('100',)
('100',)
('20',)
('50',)
*/

-- Prediction Query
SELECT Reign FROM wrestler GROUP BY Reign ORDER BY COUNT(*) DESC, Reign NULLS LAST LIMIT 1;

/*
Prediction Result:
('20',)
*/