-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('default2', 'default1'), ('-', '-'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', NULL), ('unique_14', '-'), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', '-'), ('unique_18', 'default2'), ('unique_19', '-'), ('unique_20', NULL), ('unique_21', NULL), ('unique_22', NULL), ('unique_23', 'default2'), ('unique_24', 'default2'), ('unique_25', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('-', 'unique_20', 'default1'), ('default1', 'unique_24', '-'), ('default2', 'unique_20', 'default2'), ('unique_3', 'unique_23', 'default1'), ('unique_4', 'unique_12', NULL), ('unique_5', 'unique_17', NULL), ('unique_6', 'unique_4', 'default2'), ('unique_7', 'unique_12', '-'), ('unique_8', 'unique_9', 'default2'), ('unique_9', 'unique_14', '-'), ('unique_10', 'unique_10', 'default2'), ('unique_11', 'unique_24', NULL), ('unique_12', '-', 'default1'), ('unique_13', 'unique_25', NULL), ('unique_14', 'unique_8', '-'), ('unique_15', 'unique_6', 'default2'), ('unique_16', 'default1', 'default1'), ('unique_17', 'unique_13', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_5', '-'), ('default1', 'unique_11', 'default2'), ('-', 'unique_6', NULL), ('unique_3', 'unique_15', 'default1'), ('unique_4', 'unique_9', 'default1'), ('unique_5', 'unique_19', NULL), ('unique_6', 'unique_3', 'default1'), ('unique_7', 'unique_4', 'default1'), ('unique_8', 'unique_4', 'default2'), ('unique_9', 'default1', 'default2'), ('unique_10', 'unique_10', '-'), ('unique_11', 'unique_11', NULL), ('unique_12', 'unique_17', 'default1'), ('unique_13', 'unique_8', 'default1'), ('unique_14', 'unique_17', 'default1'), ('unique_15', 'unique_14', NULL), ('unique_16', '-', NULL), ('unique_17', 'unique_13', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_14', 'unique_11', 'unique_6'), ('unique_17', 'unique_7', 'unique_6'), ('-', 'unique_6', NULL), ('unique_13', 'unique_3', 'unique_5'), ('default2', 'unique_17', 'unique_7'), ('unique_3', 'unique_10', 'unique_6'), ('unique_8', 'default2', 'default1'), ('unique_14', '-', 'default2'), ('unique_14', 'default1', 'unique_11'), ('unique_16', 'unique_12', 'unique_8'), ('default2', 'default2', 'unique_6'), ('unique_4', 'unique_6', 'unique_12'), ('unique_10', 'unique_12', 'unique_6'), ('unique_12', 'unique_6', 'unique_12'), ('unique_4', 'default2', 'unique_10'), ('unique_16', 'unique_7', 'unique_16'), ('unique_9', 'unique_16', 'unique_13'), ('unique_13', 'unique_15', 'unique_10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-' ORDER BY T2.molecule_id LIMIT 3;

/*
Gold Result:
('unique_14',)
*/

-- Prediction Query
SELECT DISTINCT m.molecule_id FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE m.label = '-' AND b.bond_type = '-' ORDER BY m.molecule_id LIMIT 3;

/*
Prediction Result:
*/