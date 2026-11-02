-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (1, 'Battle of Adrianople', '1205-04-14', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (10, 1, 'Victory', '250', 'Brig', 'Black Sea', 'Sunk');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (20, NULL, 'Aurora', '500', 'Galleon', 'Aegean Sea', 'Active');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (30, 1, 'Enterprise', '100', 'Sloop', 'Marmara', 'Captured');
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (1, 10, 'Sunk in storm', 15, 5);
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (2, 10, 'Cannon fire', 20, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, tonnage FROM ship ORDER BY name, ship.id NULLS LAST;

/*
Gold Result:
('Aurora', '500')
('Enterprise', '100')
('Victory', '250')
*/

-- Prediction Query
SELECT name, tonnage FROM ship ORDER BY name DESC, ship.id NULLS LAST;

/*
Prediction Result:
('Victory', '250')
('Enterprise', '100')
('Aurora', '500')
*/