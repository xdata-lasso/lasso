-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('default1', 'TR000_2'), ('TR000_2', 'TR000_2'), ('TR000_4', 'default2'), ('unique_4', 'TR000_4'), ('unique_5', 'TR000_4'), ('unique_6', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_4', 'unique_5', 'TR000_2'), ('TR000_2', NULL, 'TR000_2'), ('default1', 'unique_5', 'TR000_2'), ('default2', 'unique_5', NULL), ('unique_4', 'unique_4', 'TR000_4'), ('unique_5', 'unique_5', NULL), ('unique_6', 'unique_5', NULL), ('unique_7', 'unique_6', 'default2'), ('unique_8', 'default1', NULL), ('unique_9', 'default1', 'default2'), ('unique_10', 'TR000_2', 'default2'), ('unique_11', 'default2', 'TR000_4'), ('unique_12', 'TR000_4', 'default1'), ('unique_13', 'TR000_4', NULL), ('unique_14', 'unique_6', 'default1'), ('unique_15', 'unique_5', NULL), ('unique_16', 'TR000_4', 'TR000_4'), ('unique_17', 'TR000_4', 'default1'), ('unique_18', NULL, 'default2'), ('unique_19', 'unique_6', 'default1'), ('unique_20', NULL, 'default1'), ('unique_21', NULL, 'default2'), ('unique_22', NULL, 'default2'), ('unique_23', 'unique_5', 'TR000_4');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_5', 'TR000_4'), ('TR000_2', 'TR000_2', 'TR000_2'), ('default1', 'unique_6', 'TR000_2'), ('TR000_4', 'default2', 'TR000_2'), ('unique_4', 'TR000_2', 'default1'), ('unique_5', 'default1', 'TR000_2'), ('unique_6', 'unique_5', 'default1'), ('unique_7', 'unique_4', 'TR000_2'), ('unique_8', 'default2', 'default2'), ('unique_9', 'unique_5', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_7', 'unique_4', 'TR000_2'), ('unique_4', 'unique_8', 'default1'), ('unique_5', 'unique_8', 'unique_13'), ('TR000_4', 'TR000_4', 'unique_10'), ('unique_7', 'unique_6', 'unique_12'), ('TR000_2', 'TR000_4', 'unique_7'), ('unique_6', 'unique_5', 'unique_4'), ('TR000_2', 'unique_5', 'unique_22'), ('unique_9', 'unique_6', 'TR000_2'), ('TR000_4', 'unique_5', 'unique_22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Gold Result:
('unique_6',)
*/

-- Prediction Query
SELECT T2."molecule_id" FROM "connected" AS T1 INNER JOIN "atom" AS T2 ON T1."atom_id" = T2."atom_id" WHERE T1."atom_id" = 'TR000_2' AND T1."atom_id2" = 'TR000_4';

/*
Prediction Result:
('TR000_2',)
*/