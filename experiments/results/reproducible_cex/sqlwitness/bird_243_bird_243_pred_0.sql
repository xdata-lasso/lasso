-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('p', 'N'), ('n', NULL), ('P', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default1'), ('p', 'p', 'n'), ('N', 'p', 'n'), ('n', NULL, 'N'), ('P', 'n', 'n'), ('default1', 'P', 'default2'), ('unique_6', 'n', 'p'), ('unique_7', 'n', 'P'), ('unique_8', 'p', 'P'), ('unique_9', 'P', NULL), ('unique_10', 'n', 'P'), ('unique_11', 'P', 'default1'), ('unique_12', 'p', 'N'), ('unique_13', 'p', 'default1'), ('unique_14', 'p', 'default1'), ('unique_15', 'n', 'P'), ('unique_16', 'n', 'default1'), ('unique_17', NULL, 'default1'), ('unique_18', 'p', 'default2'), ('unique_19', 'n', 'default2'), ('unique_20', 'P', 'P'), ('unique_21', 'n', 'P'), ('unique_22', 'p', 'n'), ('unique_23', 'P', 'default2'), ('unique_24', 'p', 'p'), ('unique_25', 'P', NULL), ('unique_26', 'n', 'N'), ('unique_27', 'n', 'default1'), ('unique_28', 'p', NULL), ('unique_29', 'n', 'n'), ('unique_30', 'p', 'p'), ('unique_31', 'n', 'P'), ('unique_32', 'n', 'default1'), ('unique_33', NULL, 'default1'), ('unique_34', 'p', 'default1'), ('unique_35', 'P', 'P'), ('unique_36', NULL, 'default1'), ('unique_37', NULL, 'default2'), ('unique_38', 'P', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('P', NULL, 'P'), ('default1', 'P', 'N'), ('default2', 'P', 'default1'), ('N', NULL, NULL), ('p', 'n', 'default1'), ('n', NULL, 'p'), ('unique_6', 'p', 'default2'), ('unique_7', 'n', 'p'), ('unique_8', NULL, 'n'), ('unique_9', 'p', 'default1'), ('unique_10', 'p', 'default2'), ('unique_11', 'p', 'N'), ('unique_12', 'P', 'n'), ('unique_13', NULL, 'default1'), ('unique_14', 'p', 'n'), ('unique_15', NULL, 'default1'), ('unique_16', 'p', 'default2'), ('unique_17', 'P', 'P'), ('unique_18', 'P', NULL), ('unique_19', 'n', 'default2'), ('unique_20', 'n', 'P'), ('unique_21', NULL, 'default1'), ('unique_22', 'P', 'default1'), ('unique_23', 'p', 'p'), ('unique_24', 'n', 'default1'), ('unique_25', 'p', 'p'), ('unique_26', 'p', 'p'), ('unique_27', 'n', 'P'), ('unique_28', 'P', 'N'), ('unique_29', 'p', NULL), ('unique_30', 'n', 'P'), ('unique_31', 'p', NULL), ('unique_32', 'P', 'N'), ('unique_33', 'p', NULL), ('unique_34', 'P', 'n'), ('unique_35', 'n', NULL), ('unique_36', 'P', 'p');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_14', 'unique_7', 'unique_12'), ('unique_22', 'unique_11', 'unique_26'), ('unique_14', 'unique_24', 'unique_26'), ('unique_17', 'unique_28', 'unique_29'), ('unique_20', 'unique_6', 'P'), ('unique_17', 'unique_27', 'unique_16'), ('unique_21', 'unique_23', 'unique_32'), ('unique_30', 'unique_35', 'unique_28'), ('unique_17', 'default2', 'P'), ('unique_32', 'unique_20', 'unique_36'), ('unique_34', 'unique_21', 'unique_17'), ('unique_30', 'unique_9', 'n'), ('unique_20', 'unique_25', 'N'), ('unique_19', 'unique_36', 'unique_14'), ('unique_30', 'unique_19', 'unique_26'), ('unique_10', 'unique_18', 'unique_20'), ('unique_25', 'unique_21', 'unique_16'), ('unique_23', 'unique_14', 'unique_32'), ('unique_23', 'unique_34', 'unique_8'), ('unique_12', 'P', 'unique_33'), ('P', 'unique_23', 'unique_37'), ('unique_13', 'unique_9', 'unique_23'), ('unique_22', 'unique_22', 'unique_24'), ('default2', 'P', 'unique_22'), ('p', 'unique_17', 'unique_33'), ('N', 'unique_33', 'unique_26'), ('n', 'unique_10', 'unique_6'), ('unique_16', 'P', 'unique_8'), ('unique_33', 'default2', 'unique_11'), ('unique_23', 'unique_19', 'unique_11'), ('unique_7', 'unique_27', 'default2'), ('unique_7', 'unique_35', 'unique_35');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T1 ON T1.atom_id = T3.atom_id INNER JOIN atom AS T2 ON T2.atom_id = T3.atom_id2 WHERE (T1.element = 'P' AND T2.element = 'N') OR (T1.element = 'N' AND T2.element = 'P');

/*
Prediction Result:
('unique_29',)
('unique_36',)
*/