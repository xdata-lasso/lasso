-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('-', '-'), ('default2', '-'), ('default1', 'default1'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', '-'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', '-'), ('unique_10', NULL), ('unique_11', '-'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', '-'), ('unique_16', NULL), ('unique_17', 'default2'), ('unique_18', 'default1'), ('unique_19', NULL), ('unique_20', NULL), ('unique_21', 'default2'), ('unique_22', 'default2'), ('unique_23', 'default2'), ('unique_24', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('-', 'unique_6', NULL), ('default1', 'unique_8', 'default2'), ('default2', 'unique_18', 'default2'), ('unique_3', 'unique_12', 'default2'), ('unique_4', NULL, NULL), ('unique_5', 'default1', 'default1'), ('unique_6', 'unique_7', '-'), ('unique_7', 'unique_22', '-'), ('unique_8', 'unique_16', '-'), ('unique_9', 'unique_24', 'default1'), ('unique_10', 'unique_19', NULL), ('unique_11', 'unique_17', 'default1'), ('unique_12', 'unique_24', 'default1'), ('unique_13', NULL, 'default1'), ('unique_14', 'unique_14', '-'), ('unique_15', 'unique_5', NULL), ('unique_16', 'unique_17', '-'), ('unique_17', 'unique_5', NULL), ('unique_18', 'unique_6', NULL), ('unique_19', 'unique_14', '-'), ('unique_20', 'unique_8', '-'), ('unique_21', 'unique_19', 'default1'), ('unique_22', 'unique_9', 'default2'), ('unique_23', 'unique_10', '-'), ('unique_24', 'unique_6', '-'), ('unique_25', 'unique_7', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', 'unique_5', 'default1'), ('default1', 'unique_23', 'default2'), ('default2', 'unique_9', '-'), ('unique_3', 'unique_17', 'default1'), ('unique_4', 'unique_3', NULL), ('unique_5', 'unique_16', NULL), ('unique_6', 'unique_21', 'default1'), ('unique_7', 'unique_3', 'default2'), ('unique_8', 'unique_18', '-'), ('unique_9', 'unique_8', 'default1'), ('unique_10', 'default1', '-'), ('unique_11', 'unique_11', 'default2'), ('unique_12', 'unique_21', 'default1'), ('unique_13', 'unique_5', '-'), ('unique_14', 'unique_12', 'default2'), ('unique_15', 'unique_18', 'default2'), ('unique_16', 'unique_5', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_5', 'unique_13', NULL), ('default1', 'unique_15', 'unique_4'), ('unique_6', 'unique_8', '-'), ('unique_11', 'unique_4', 'unique_19'), ('unique_8', 'unique_3', 'unique_6'), ('unique_5', 'unique_16', 'unique_4'), ('unique_5', 'unique_10', 'unique_19'), ('unique_13', 'unique_8', '-'), ('default1', 'default1', 'unique_21'), ('unique_8', 'unique_8', 'unique_9'), ('unique_16', 'unique_15', 'unique_19'), ('unique_5', 'default2', 'unique_17'), ('unique_10', 'unique_15', NULL), ('unique_3', 'unique_6', 'unique_4'), ('unique_13', 'unique_5', 'unique_23'), ('unique_4', 'unique_15', 'unique_17'), ('unique_9', 'unique_10', 'unique_18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Gold Result:
('unique_19', 'unique_11', 'unique_4')
('unique_6', 'unique_8', 'unique_3')
('unique_19', 'unique_5', 'unique_10')
('unique_19', 'unique_16', 'unique_15')
('unique_23', 'unique_13', 'unique_5')
*/

-- Prediction Query
SELECT T1.bond_id, T2.atom_id, T3.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN connected AS T3 ON T1.bond_id = T3.bond_id WHERE T1.bond_type = '-';

/*
Prediction Result:
('unique_19', 'unique_11', 'unique_10')
('unique_19', 'unique_11', 'unique_15')
('unique_19', 'unique_11', 'unique_4')
('unique_6', 'unique_8', 'unique_3')
('unique_19', 'unique_5', 'unique_10')
('unique_19', 'unique_5', 'unique_15')
('unique_19', 'unique_5', 'unique_4')
('unique_19', 'unique_16', 'unique_10')
('unique_19', 'unique_16', 'unique_15')
('unique_19', 'unique_16', 'unique_4')
('unique_23', 'unique_13', 'unique_5')
*/