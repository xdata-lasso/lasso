-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'TR001_3_4'), ('default1', 'TR001_3_4'), ('TR001_3_4', 'default1'), ('unique_3', 'default1'), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', 'default2'), ('unique_14', 'TR001_3_4'), ('unique_15', NULL), ('unique_16', 'TR001_3_4'), ('unique_17', 'TR001_3_4'), ('unique_18', NULL), ('unique_19', 'default1'), ('unique_20', NULL), ('unique_21', 'default2'), ('unique_22', 'default1'), ('unique_23', 'TR001_3_4'), ('unique_24', 'TR001_3_4'), ('unique_25', 'TR001_3_4'), ('unique_26', 'default2'), ('unique_27', NULL), ('unique_28', 'TR001_3_4'), ('unique_29', NULL), ('unique_30', 'default2'), ('unique_31', 'default2'), ('unique_32', 'default1'), ('unique_33', 'default2'), ('unique_34', 'default2'), ('unique_35', NULL), ('unique_36', 'TR001_3_4');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_3_4', 'unique_7', 'TR001_3_4');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_27', 'TR001_3_4'), ('TR001_3_4', 'unique_7', NULL), ('default1', 'unique_14', NULL), ('unique_3', 'unique_26', 'TR001_3_4'), ('unique_4', 'unique_11', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_3', 'TR001_3_4'), ('unique_3', 'unique_4', NULL), ('TR001_3_4', 'default2', NULL), ('TR001_3_4', 'default1', NULL), ('default1', 'default2', 'TR001_3_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT COALESCE(atom1.element, atom2.element)) AS unique_elements FROM connected INNER JOIN atom AS atom1 ON connected.atom_id = atom1.atom_id INNER JOIN atom AS atom2 ON connected.atom_id2 = atom2.atom_id WHERE connected.bond_id = 'TR001_3_4';

/*
Prediction Result:
(1,)
*/