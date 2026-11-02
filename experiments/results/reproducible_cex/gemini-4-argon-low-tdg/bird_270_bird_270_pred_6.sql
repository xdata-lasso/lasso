-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
-- Tests COUNT(T2.label) vs COUNT(DISTINCT T2.molecule_id) when one molecule has multiple 'ca' atoms vs multiple molecules having one 'ca' atom
INSERT INTO molecule (molecule_id, label) VALUES ('m1', 'label_A');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', 'label_B');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', 'label_B');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm3', 'ca');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('label_A',)
*/

-- Prediction Query
SELECT label FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca') GROUP BY label ORDER BY COUNT(label) DESC, label NULLS LAST LIMIT 1;

/*
Prediction Result:
('label_B',)
*/