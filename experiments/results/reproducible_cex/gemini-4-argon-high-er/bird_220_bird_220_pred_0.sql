-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', 'TR000', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR000' ORDER BY T.element LIMIT 3;

/*
Gold Result:
('c',)
*/

-- Prediction Query
SELECT CASE WHEN element = 'cl' THEN 'Chlorine' WHEN element = 'c' THEN 'Carbon' WHEN element = 'h' THEN 'Hydrogen' WHEN element = 'o' THEN 'Oxygen' WHEN element = 's' THEN 'Sulfur' WHEN element = 'n' THEN 'Nitrogen' WHEN element = 'p' THEN 'Phosphorus' WHEN element = 'na' THEN 'Sodium' WHEN element = 'br' THEN 'Bromine' WHEN element = 'f' THEN 'Fluorine' WHEN element = 'i' THEN 'Iodine' WHEN element = 'sn' THEN 'Tin' WHEN element = 'pb' THEN 'Lead' WHEN element = 'te' THEN 'Tellurium' WHEN element = 'ca' THEN 'Calcium' END AS "Element" FROM atom WHERE molecule_id;

/*
Prediction Result:
*/