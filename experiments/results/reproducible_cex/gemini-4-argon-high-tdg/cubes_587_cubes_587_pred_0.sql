-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (1, 'Battle of Adrianople', '1205-04-14', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (1, 1, 'Zephyr', '300', 'Brig', 'English Channel', 'Sunk');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (2, 1, 'Alpha', '1000', 'Cargo ship', 'North Sea', 'Captured');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (3, 1, 'Bravo', '200', '2-gunaisen', 'Black Sea', 'Wrecked');
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (1, 1, 'Drowned', 10, 5);
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (2, 2, 'Cannon fire', 0, 12);
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (3, 3, 'Boarding', 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, tonnage FROM ship ORDER BY name, ship.id NULLS LAST;

/*
Gold Result:
('Alpha', '1000')
('Bravo', '200')
('Zephyr', '300')
*/

-- Prediction Query
SELECT name, tonnage FROM ship ORDER BY name DESC, ship.id NULLS LAST;

/*
Prediction Result:
('Zephyr', '300')
('Bravo', '200')
('Alpha', '1000')
*/