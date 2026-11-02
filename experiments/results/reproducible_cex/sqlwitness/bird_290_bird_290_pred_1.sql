-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'n'), ('o', 'i'), ('ca', 'n'), ('h', 'default1'), ('pb', 'o'), ('TR151', 'TR151'), ('f', 'na'), ('te', 'f'), ('s', 'TR151'), ('na', 'default1'), ('p', 'default2'), ('i', 'te'), ('sn', 'default1'), ('cl', 'h'), ('c', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('na', 'te', 'pb'), ('sn', 'na', 'default2'), ('default1', 'cl', NULL), ('default2', 'i', 'c'), ('te', 'ca', 's'), ('n', 'pb', 's'), ('ca', 'cl', 'f'), ('f', 'pb', 'n'), ('pb', 'na', 's'), ('p', 's', 'TR151'), ('h', 'h', 'f'), ('cl', 'te', 'default1'), ('o', 'cl', 'ca'), ('TR151', 'pb', 'na'), ('i', NULL, 'TR151'), ('s', 'i', 'p'), ('c', 'f', 'te'), ('br', 'o', 'na'), ('unique_18', 'p', 'na'), ('unique_19', 'TR151', 'default1'), ('unique_20', 'pb', NULL), ('unique_21', 'c', 'te'), ('unique_22', 'o', 'default2'), ('unique_23', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT element FROM atom WHERE molecule_id = 'TR151' AND element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
*/