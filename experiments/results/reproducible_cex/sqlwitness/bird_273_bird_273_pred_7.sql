-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', '+'), ('cl', 'default1'), ('default1', 'cl'), ('default2', '+'), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default1', 'cl'), ('+', 'default2', NULL), ('default2', 'default2', 'cl'), ('cl', NULL, 'cl'), ('unique_4', '+', '+'), ('unique_5', 'unique_6', 'default1'), ('unique_6', '+', NULL), ('unique_7', 'unique_7', 'default2'), ('unique_8', NULL, 'cl'), ('unique_9', 'unique_6', 'default2'), ('unique_10', 'unique_6', 'cl'), ('unique_11', NULL, 'cl'), ('unique_12', 'unique_6', 'default2'), ('unique_13', 'default1', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN atom.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(atom.atom_id) AS percentage FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
(25.0,)
*/