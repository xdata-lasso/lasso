-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('i', NULL), ('default2', 'default1'), ('unique_3', 'i'), ('unique_4', NULL), ('unique_5', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_4', 'i'), ('default2', 'unique_4', 'default2'), ('i', NULL, NULL), ('unique_3', 'unique_3', 'default1'), ('unique_4', 'unique_3', 'i'), ('unique_5', 'default2', 'default2'), ('unique_6', 'i', 'default2'), ('unique_7', 'unique_5', 'default1'), ('unique_8', 'default1', 'i'), ('unique_9', 'default2', NULL), ('unique_10', 'unique_3', NULL), ('unique_11', 'unique_3', 'default1'), ('unique_12', NULL, 'default1'), ('unique_13', 'default1', 'i'), ('unique_14', 'i', 'default2'), ('unique_15', 'default2', NULL), ('unique_16', NULL, 'i'), ('unique_17', 'unique_3', 'i'), ('unique_18', 'unique_4', NULL), ('unique_19', 'unique_3', 'default1'), ('unique_20', 'i', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_4', 'i'), ('i', 'unique_3', NULL), ('default1', 'default2', 'default1'), ('unique_3', 'unique_4', NULL), ('unique_4', 'unique_3', NULL), ('unique_5', 'default2', 'default1'), ('unique_6', 'default2', 'default2'), ('unique_7', 'i', NULL), ('unique_8', 'i', 'i'), ('unique_9', 'i', 'i'), ('unique_10', 'unique_3', NULL), ('unique_11', 'unique_3', NULL), ('unique_12', 'unique_3', 'default2'), ('unique_13', 'unique_4', 'default1'), ('unique_14', 'unique_3', NULL), ('unique_15', 'default2', 'i'), ('unique_16', 'i', 'default2'), ('unique_17', NULL, NULL), ('unique_18', 'unique_5', NULL), ('unique_19', 'i', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_14', 'unique_3', 'unique_9'), ('unique_14', 'unique_5', NULL), ('unique_11', 'unique_10', 'unique_12'), ('unique_9', 'unique_3', 'unique_18'), ('unique_10', 'default2', 'unique_9'), ('default2', 'default2', 'unique_19'), ('unique_10', 'unique_19', 'unique_3'), ('unique_7', 'unique_12', 'unique_15'), ('unique_14', 'unique_13', 'unique_10'), ('unique_9', 'unique_18', 'unique_8'), ('i', 'unique_18', 'unique_19'), ('unique_10', 'unique_10', 'unique_17'), ('unique_9', 'unique_6', 'unique_3'), ('unique_9', 'default2', 'unique_13'), ('unique_9', 'unique_9', 'default2'), ('unique_10', 'unique_3', 'i'), ('unique_5', 'unique_13', 'unique_20'), ('unique_15', 'unique_6', 'unique_15'), ('unique_11', 'default2', 'unique_6'), ('unique_17', 'unique_16', 'unique_12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(DISTINCT T1.atom_id) AS average_bonds FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Prediction Result:
(2.3333333333333335,)
*/