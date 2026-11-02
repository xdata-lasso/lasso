-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('default1', 'default2'), ('-', 'default1'), ('unique_3', NULL), ('unique_4', '-'), ('unique_5', '-'), ('unique_6', 'default1'), ('unique_7', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', 'unique_6', NULL), ('default2', 'default1', NULL), ('default1', '-', 'default2'), ('unique_3', 'unique_7', 'default2'), ('unique_4', 'default1', 'default1'), ('unique_5', 'unique_3', NULL), ('unique_6', 'unique_4', '-'), ('unique_7', 'unique_7', 'default2'), ('unique_8', NULL, 'default2'), ('unique_9', 'unique_4', '-'), ('unique_10', 'unique_7', 'default1'), ('unique_11', 'unique_6', 'default1'), ('unique_12', 'unique_6', NULL), ('unique_13', 'unique_3', NULL), ('unique_14', 'default1', 'default2'), ('unique_15', 'unique_4', 'default2'), ('unique_16', 'unique_5', 'default1'), ('unique_17', 'unique_3', '-'), ('unique_18', 'default2', 'default1'), ('unique_19', 'unique_3', 'default2'), ('unique_20', 'unique_6', 'default2'), ('unique_21', 'unique_5', 'default2'), ('unique_22', 'unique_6', 'default2'), ('unique_23', 'unique_3', 'default2'), ('unique_24', '-', NULL), ('unique_25', 'unique_5', 'default1'), ('unique_26', 'unique_4', NULL), ('unique_27', 'default2', 'default2'), ('unique_28', 'default2', 'default1'), ('unique_29', 'default2', '-'), ('unique_30', 'default1', NULL), ('unique_31', 'default1', '-'), ('unique_32', 'unique_3', '-'), ('unique_33', 'default2', 'default1'), ('unique_34', 'unique_3', 'default1'), ('unique_35', 'unique_4', 'default2'), ('unique_36', 'default1', NULL), ('unique_37', 'default1', '-'), ('unique_38', '-', '-'), ('unique_39', 'default1', 'default2'), ('unique_40', 'unique_6', 'default2'), ('unique_41', 'unique_4', NULL), ('unique_42', 'default2', 'default1'), ('unique_43', 'unique_5', 'default2'), ('unique_44', 'unique_4', '-'), ('unique_45', 'unique_3', '-'), ('unique_46', '-', NULL), ('unique_47', 'default1', '-'), ('unique_48', 'unique_4', 'default1'), ('unique_49', 'unique_6', '-'), ('unique_50', 'unique_4', 'default1'), ('unique_51', NULL, 'default1'), ('unique_52', 'default1', 'default1'), ('unique_53', 'unique_5', 'default1'), ('unique_54', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T1.molecule_id, COUNT(T2.atom_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '-' GROUP BY T1.molecule_id HAVING COUNT(T2.atom_id) > 5) AS t;

/*
Gold Result:
('unique_4',)
*/

-- Prediction Query
SELECT T1.molecule_id, T1.label FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id GROUP BY T1.molecule_id, T1.label HAVING COUNT(T2.atom_id) > 5 AND T1.label = '-';

/*
Prediction Result:
('unique_4', '-')
*/