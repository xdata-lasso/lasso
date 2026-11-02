-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('p', NULL), ('n', 'default1'), ('default2', 'default1'), ('default1', 'default2'), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', 'n'), ('unique_7', 'p'), ('unique_8', 'n'), ('unique_9', 'p'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', 'p'), ('unique_14', NULL), ('unique_15', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('n', 'n', 'p'), ('default2', 'n', 'default2'), ('default1', 'unique_14', 'default1'), ('p', 'unique_11', 'default2'), ('unique_4', 'unique_8', NULL), ('unique_5', 'unique_7', 'n'), ('unique_6', 'unique_14', 'p'), ('unique_7', 'unique_4', NULL), ('unique_8', 'unique_5', 'p'), ('unique_9', 'unique_15', 'default1'), ('unique_10', 'unique_4', 'default1'), ('unique_11', 'unique_14', 'p'), ('unique_12', 'unique_10', 'n'), ('unique_13', 'p', 'default1'), ('unique_14', 'p', 'n'), ('unique_15', 'unique_14', NULL), ('unique_16', 'unique_15', 'n'), ('unique_17', 'default2', NULL), ('unique_18', 'p', 'p'), ('unique_19', 'unique_14', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default2', NULL), ('default1', 'unique_5', 'p'), ('n', 'unique_12', 'n'), ('p', 'unique_5', 'n');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default2', 'default1', 'unique_5'), ('n', 'default1', 'p'), ('default1', 'p', 'unique_7'), ('p', 'p', 'unique_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('unique_7',)
*/

-- Prediction Query
SELECT DISTINCT b.bond_id FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a1 ON c.atom_id = a1.atom_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE (a1.element = 'p' AND a2.element = 'n') OR (a1.element = 'n' AND a2.element = 'p');

/*
Prediction Result:
('p',)
('unique_7',)
*/