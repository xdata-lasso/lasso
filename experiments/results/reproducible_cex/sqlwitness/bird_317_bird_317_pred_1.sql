-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', NULL), ('default2', 'cl'), ('cl', 'default2'), ('default1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('cl', NULL, 'default2'), ('default1', NULL, 'default1'), ('+', NULL, NULL), ('default2', 'default1', NULL), ('unique_4', '+', 'default1'), ('unique_5', 'default2', NULL), ('unique_6', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T2.label = '+' AND T1.element = 'cl' THEN T2.molecule_id ELSE NULL END) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN atom.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100.0) / COUNT(molecule.molecule_id) AS percentage FROM molecule JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
(None,)
*/