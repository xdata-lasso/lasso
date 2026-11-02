-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('21', '21'), ('25', '21'), ('default1', 'default1'), ('default2', '21'), ('+', '+'), ('unique_5', 'default1'), ('unique_6', '21'), ('unique_7', '21'), ('unique_8', '25'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', '+'), ('unique_12', '+'), ('unique_13', '25'), ('unique_14', NULL), ('unique_15', '+'), ('unique_16', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('25', 'default2', 'default2'), ('21', 'unique_5', '21'), ('+', 'default1', '25'), ('default2', 'unique_8', '25'), ('default1', 'unique_7', 'default1'), ('unique_5', 'unique_6', 'default2'), ('unique_6', 'unique_15', NULL), ('unique_7', 'unique_16', '+'), ('unique_8', 'unique_11', NULL), ('unique_9', 'unique_16', 'default2'), ('unique_10', 'unique_8', 'default1'), ('unique_11', NULL, 'default1'), ('unique_12', '25', 'default1'), ('unique_13', 'unique_11', '21'), ('unique_14', 'unique_16', 'default1'), ('unique_15', 'default1', 'default1'), ('unique_16', 'unique_6', 'default1'), ('unique_17', 'unique_7', NULL), ('unique_18', 'default1', 'default2'), ('unique_19', 'default2', 'default1'), ('unique_20', 'default2', 'default2'), ('unique_21', 'unique_14', 'default2'), ('unique_22', 'unique_15', '21'), ('unique_23', 'unique_7', '25'), ('unique_24', 'unique_14', 'default2'), ('unique_25', NULL, 'default2'), ('unique_26', 'unique_15', '+'), ('unique_27', 'unique_6', '+'), ('unique_28', 'unique_9', '+'), ('unique_29', 'unique_7', '21'), ('unique_30', 'unique_6', '25'), ('unique_31', 'default2', '+'), ('unique_32', 'unique_11', '25'), ('unique_33', 'unique_13', NULL), ('unique_34', NULL, NULL), ('unique_35', '+', NULL), ('unique_36', 'unique_16', '25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('unique_15',)
*/

-- Prediction Query
SELECT DISTINCT T2.molecule_id, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, 7, 2) BETWEEN 21 AND 25 AND T2.label = '+';

/*
Prediction Result:
*/