-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('h', 'h'), ('default1', 'default1'), ('default2', 'H'), ('H', NULL), ('+', '+'), ('unique_5', 'H'), ('unique_6', 'default1'), ('unique_7', '+'), ('unique_8', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('H', 'unique_6', '+'), ('+', 'H', 'default1'), ('default1', 'unique_8', 'h'), ('h', 'unique_5', NULL), ('default2', '+', 'h'), ('unique_5', 'H', NULL), ('unique_6', 'unique_8', NULL), ('unique_7', 'unique_6', 'H'), ('unique_8', '+', '+'), ('unique_9', NULL, 'default1'), ('unique_10', '+', 'default2'), ('unique_11', 'default2', 'h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) AS atomnums_h FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'h';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(atom_id) FROM atom WHERE molecule_id IN (SELECT molecule_id FROM molecule WHERE label = '+') AND element = 'H';

/*
Prediction Result:
(0,)
*/