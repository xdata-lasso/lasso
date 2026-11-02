-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('ca', NULL), ('default2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', 'ca'), ('unique_10', 'default2'), ('unique_11', 'ca'), ('unique_12', 'default1'), ('unique_13', 'ca'), ('unique_14', 'ca'), ('unique_15', 'default1'), ('unique_16', 'default2'), ('unique_17', 'default1'), ('unique_18', NULL), ('unique_19', NULL), ('unique_20', 'default1'), ('unique_21', NULL), ('unique_22', 'ca'), ('unique_23', 'default1'), ('unique_24', NULL), ('unique_25', 'default1'), ('unique_26', NULL), ('unique_27', 'default2'), ('unique_28', 'ca'), ('unique_29', 'default2'), ('unique_30', 'ca'), ('unique_31', NULL), ('unique_32', 'default1'), ('unique_33', 'default2'), ('unique_34', 'default2'), ('unique_35', 'default2'), ('unique_36', 'default1'), ('unique_37', NULL), ('unique_38', NULL), ('unique_39', NULL), ('unique_40', 'ca'), ('unique_41', 'default1'), ('unique_42', 'default1'), ('unique_43', 'default1'), ('unique_44', 'ca'), ('unique_45', NULL), ('unique_46', 'default1'), ('unique_47', 'ca'), ('unique_48', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_34', 'ca'), ('ca', 'unique_8', 'ca'), ('default1', 'unique_14', NULL), ('unique_3', 'unique_25', 'default2'), ('unique_4', 'unique_44', NULL), ('unique_5', 'unique_19', 'ca'), ('unique_6', 'unique_34', 'ca'), ('unique_7', 'unique_27', 'default1'), ('unique_8', 'unique_27', 'ca'), ('unique_9', 'unique_34', 'ca'), ('unique_10', 'unique_37', 'default2'), ('unique_11', 'unique_46', 'ca'), ('unique_12', 'unique_11', 'ca'), ('unique_13', 'unique_3', 'default1'), ('unique_14', 'unique_35', 'ca'), ('unique_15', 'unique_11', NULL), ('unique_16', 'unique_25', 'default2'), ('unique_17', 'unique_5', 'default2'), ('unique_18', 'unique_27', 'ca'), ('unique_19', 'unique_35', 'ca'), ('unique_20', 'unique_41', 'ca'), ('unique_21', 'unique_35', 'default1'), ('unique_22', 'unique_34', 'default1'), ('unique_23', 'unique_3', 'ca'), ('unique_24', 'unique_6', 'default1'), ('unique_25', 'unique_46', NULL), ('unique_26', 'unique_26', 'ca'), ('unique_27', 'default1', NULL), ('unique_28', 'unique_42', 'ca'), ('unique_29', 'unique_31', 'default1'), ('unique_30', 'unique_45', 'default2'), ('unique_31', NULL, 'ca'), ('unique_32', 'unique_28', 'default1'), ('unique_33', 'unique_3', 'default1'), ('unique_34', 'unique_38', 'ca'), ('unique_35', 'unique_19', 'ca'), ('unique_36', 'unique_4', 'default2'), ('unique_37', NULL, 'default1'), ('unique_38', 'unique_17', NULL), ('unique_39', 'unique_28', NULL), ('unique_40', 'unique_23', 'default2'), ('unique_41', 'unique_13', 'default1'), ('unique_42', 'unique_24', NULL), ('unique_43', 'unique_45', 'default1'), ('unique_44', 'unique_27', 'ca'), ('unique_45', 'unique_12', 'ca'), ('unique_46', 'unique_28', 'default1'), ('unique_47', 'unique_19', 'ca'), ('unique_48', NULL, 'default2'), ('unique_49', 'unique_17', 'ca');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT label FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca') GROUP BY label ORDER BY COUNT(label) DESC, label NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/