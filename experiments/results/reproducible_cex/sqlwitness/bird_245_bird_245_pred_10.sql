-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('i', NULL), ('default1', 'default2'), ('default2', 'default2'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'i'), ('unique_10', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_8', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('i', 'unique_8', 'default2'), ('default1', 'unique_10', 'default2'), ('default2', 'unique_10', NULL), ('unique_3', 'unique_7', NULL), ('unique_4', 'default2', 'i'), ('unique_5', 'unique_9', 'default1'), ('unique_6', 'unique_6', 'default2'), ('unique_7', 'unique_9', 'i'), ('unique_8', 'unique_10', 'default2'), ('unique_9', NULL, 'i'), ('unique_10', 'default1', 'i'), ('unique_11', 'i', 'default1'), ('unique_12', NULL, 'default1'), ('unique_13', 'unique_7', 'default2'), ('unique_14', 'unique_8', NULL), ('unique_15', 'default1', NULL), ('unique_16', NULL, 'i'), ('unique_17', 'unique_7', 'default2'), ('unique_18', 'unique_3', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 'unique_14', NULL), ('unique_11', 'default1', NULL), ('default2', 'unique_13', NULL), ('unique_4', 'unique_17', 'default2'), ('unique_6', 'default2', NULL), ('unique_7', 'unique_4', 'default2'), ('unique_16', 'unique_5', NULL), ('default2', 'unique_14', NULL), ('unique_16', 'default1', 'default2'), ('unique_7', 'default2', NULL), ('unique_9', 'unique_7', 'default2'), ('i', 'i', NULL), ('unique_12', 'unique_6', 'default2'), ('unique_6', 'default1', NULL), ('unique_11', 'unique_17', 'default2'), ('unique_16', 'unique_9', 'default2'), ('i', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(0.7142857142857143,)
*/

-- Prediction Query
SELECT AVG(num_bonds) AS average_bonds FROM (SELECT atom_id, COUNT(bond_id) AS num_bonds FROM (SELECT a.atom_id, c.bond_id FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id WHERE a.element = 'i') AS iodine_atoms GROUP BY atom_id) AS iodine_bonds_count;

/*
Prediction Result:
(1.25,)
*/