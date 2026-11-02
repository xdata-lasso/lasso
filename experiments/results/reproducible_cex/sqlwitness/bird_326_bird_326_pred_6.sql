-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('s', '='), ('default1', 'default1'), (' = ', ' = '), ('=', 'default2'), ('default2', '='), ('unique_5', 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', '=', 'default2'), ('s', ' = ', NULL), ('=', '=', '='), ('default1', ' = ', 'default1'), (' = ', '=', 'default2'), ('unique_5', ' = ', NULL), ('unique_6', '=', ' = '), ('unique_7', ' = ', 's'), ('unique_8', 'default2', NULL), ('unique_9', '=', NULL), ('unique_10', '=', 'default2'), ('unique_11', '=', 's'), ('unique_12', '=', 's'), ('unique_13', 's', 's'), ('unique_14', '=', 'default2'), ('unique_15', 'unique_5', 'default1'), ('unique_16', 's', 'default1'), ('unique_17', NULL, ' = '), ('unique_18', 's', '='), ('unique_19', ' = ', NULL), ('unique_20', 'default1', 'default2'), ('unique_21', 'unique_5', ' = '), ('unique_22', 'default2', '='), ('unique_23', '=', 'default2'), ('unique_24', 'unique_5', NULL), ('unique_25', 'default2', 'default2'), ('unique_26', 'unique_5', 's'), ('unique_27', NULL, NULL), ('unique_28', 'default2', 'default2'), ('unique_29', 'default2', 'default1'), ('unique_30', 's', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('=', 'default2', '='), ('s', ' = ', 's'), ('default2', 's', 'default1'), (' = ', ' = ', '='), ('default1', 'default1', ' = '), ('unique_5', 'default2', 'default2'), ('unique_6', 'unique_5', 'default1'), ('unique_7', '=', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('s', 'unique_5', 'unique_6'), ('default2', '=', 'unique_30'), ('unique_7', '=', 'unique_25'), ('unique_7', 'unique_5', 'unique_16'), ('=', '=', ' = '), ('unique_6', 'default2', 'unique_9'), ('default2', 'unique_6', 'unique_18'), ('unique_6', 'unique_5', 'unique_18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T4.molecule_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id INNER JOIN molecule AS T4 ON T3.molecule_id = T4.molecule_id WHERE T1.element = 's' AND T3.bond_type = ' = ';

/*
Prediction Result:
('=',)
*/