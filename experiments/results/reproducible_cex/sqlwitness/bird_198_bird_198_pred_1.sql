-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('-', 'default2'), ('default1', '+'), ('+', 'default2'), ('unique_4', '+'), ('unique_5', 'default1'), ('unique_6', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', '+', 'default2'), ('default1', '-', 'default2'), ('+', 'unique_5', '+'), ('-', 'default1', 'default2'), ('unique_4', 'default2', 'default1'), ('unique_5', 'unique_4', NULL), ('unique_6', '-', 'default1'), ('unique_7', 'default2', 'default2'), ('unique_8', 'unique_4', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', '-', 'default1'), ('+', 'default2', 'default1'), ('-', 'unique_6', 'default1'), ('default2', 'unique_6', '-'), ('unique_4', 'unique_5', 'default1'), ('unique_5', 'unique_6', '-'), ('unique_6', 'default2', NULL), ('unique_7', '+', 'default2'), ('unique_8', 'default1', 'default2'), ('unique_9', 'unique_6', '+');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_7', 'unique_8', 'unique_7'), ('default2', 'unique_7', 'unique_5'), ('+', 'unique_6', 'unique_8'), ('default1', 'unique_6', 'unique_4'), ('-', 'unique_6', 'unique_4'), ('default1', 'unique_5', '+'), ('unique_4', '-', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN B.bond_type = '-' THEN A.atom_id ELSE NULL END) AS REAL) / COUNT(A.atom_id) AS avg_single_bonded_atoms FROM molecule AS M INNER JOIN atom AS A ON M.molecule_id = A.molecule_id INNER JOIN connected AS C ON A.atom_id = C.atom_id OR A.atom_id = C.atom_id2 INNER JOIN bond AS B ON C.bond_id = B.bond_id WHERE M.label = '+';

/*
Prediction Result:
(0.0,)
*/