-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (1, 'Battle of Varna', '1190-01-01', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (2, 'Battle of Adrianople', '1254-01-01', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (5, 'Battle of Klokotnitsa', '1230-03-09', 'Ivan Asen II', 'Theodore', 'Bulgarian victory');
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (10, 'Battle of Adrianople', '1205-04-14', 'Boril', 'Henry', 'Latin victory');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (1, 10, 'Dromon I', '250', 'Galley', 'Aegean Sea', 'Sunk');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (2, 10, 'Dromon II', '300', 'Galley', 'Aegean Sea', 'Captured');
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (1, 1, 'Sinking casualty', 15, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM battle ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('Battle of Adrianople', '1254-01-01')
('Battle of Adrianople', '1205-04-14')
('Battle of Klokotnitsa', '1230-03-09')
('Battle of Varna', '1190-01-01')
*/

-- Prediction Query
SELECT name, date FROM battle;

/*
Prediction Result:
('Battle of Varna', '1190-01-01')
('Battle of Adrianople', '1254-01-01')
('Battle of Klokotnitsa', '1230-03-09')
('Battle of Adrianople', '1205-04-14')
*/