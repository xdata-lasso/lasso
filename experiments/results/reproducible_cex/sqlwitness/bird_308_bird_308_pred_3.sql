-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default2'), ('default1', 'default2'), ('cl', 'cl'), ('unique_3', 'default2'), ('unique_4', 'cl'), ('unique_5', 'cl'), ('unique_6', NULL), ('unique_7', 'cl'), ('unique_8', 'cl'), ('unique_9', 'cl'), ('unique_10', 'cl'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', NULL), ('unique_14', 'default2'), ('unique_15', 'cl'), ('unique_16', 'default1'), ('unique_17', 'cl'), ('unique_18', 'default2'), ('unique_19', 'default2'), ('unique_20', 'default1'), ('unique_21', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('cl', 'unique_10', 'default1'), ('default1', 'unique_4', 'default1'), ('default2', 'unique_6', NULL), ('unique_3', 'unique_10', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('cl', 'unique_5', NULL), ('default1', 'unique_3', 'default2'), ('default2', NULL, 'default1'), ('unique_3', 'unique_5', 'default2'), ('unique_4', 'unique_13', 'default1'), ('unique_5', 'unique_8', 'default1'), ('unique_6', 'unique_16', 'cl'), ('unique_7', 'cl', 'cl'), ('unique_8', 'unique_11', 'default2'), ('unique_9', 'unique_13', 'cl'), ('unique_10', 'unique_13', 'default1'), ('unique_11', 'cl', 'cl'), ('unique_12', 'unique_7', 'default2'), ('unique_13', 'unique_10', 'default1'), ('unique_14', 'unique_12', 'default1'), ('unique_15', 'unique_5', 'cl'), ('unique_16', 'unique_9', 'cl'), ('unique_17', 'unique_3', 'default2'), ('unique_18', 'unique_8', 'cl'), ('unique_19', 'default2', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_17', 'unique_9', 'cl'), ('unique_4', 'unique_14', NULL), ('unique_13', 'unique_17', NULL), ('unique_16', 'unique_8', 'default2'), ('unique_5', 'unique_5', NULL), ('unique_7', 'unique_4', 'default2'), ('unique_10', 'unique_10', NULL), ('unique_17', 'unique_14', 'cl'), ('unique_10', 'unique_16', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT bond.bond_id) FROM bond JOIN connected ON bond.bond_id = connected.bond_id JOIN atom ON connected.atom_id = atom.atom_id WHERE atom.element = 'cl';

/*
Prediction Result:
(1,)
*/