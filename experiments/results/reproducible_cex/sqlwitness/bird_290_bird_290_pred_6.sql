-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR151', 'br'), ('te', 'pb'), ('default2', 'cl'), ('i', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('s', NULL, 'cl'), ('default1', 'default2', 'n'), ('TR151', NULL, 'na'), ('default2', 'te', 'TR151'), ('br', 'i', 'default2'), ('pb', 'i', 'TR151'), ('n', 'TR151', 'ca'), ('h', 'default2', 's'), ('p', 'te', 'n'), ('na', 'TR151', 's'), ('i', 'te', 'pb'), ('te', 'default2', 'f'), ('f', 'TR151', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('ca',)
('s',)
('default1',)
*/

-- Prediction Query
SELECT element FROM atom WHERE molecule_id = 'TR151' AND element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
('ca',)
('s',)
*/