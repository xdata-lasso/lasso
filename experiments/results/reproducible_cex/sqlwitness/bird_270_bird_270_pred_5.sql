-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('ca', NULL), ('default2', 'ca'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'ca'), ('unique_8', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_8', 'default2'), ('default2', 'unique_4', 'default2'), ('ca', 'unique_7', 'default2'), ('unique_3', 'default2', 'ca'), ('unique_4', NULL, 'ca'), ('unique_5', 'unique_5', 'default1'), ('unique_6', NULL, 'ca'), ('unique_7', 'unique_3', 'default1'), ('unique_8', NULL, 'ca'), ('unique_9', 'unique_3', NULL), ('unique_10', NULL, 'default2'), ('unique_11', 'unique_7', 'default2'), ('unique_12', 'unique_8', NULL), ('unique_13', 'default1', 'default2'), ('unique_14', 'unique_4', 'default1'), ('unique_15', 'unique_7', 'default1'), ('unique_16', 'unique_5', 'default2'), ('unique_17', 'ca', 'default2'), ('unique_18', NULL, NULL), ('unique_19', 'ca', 'ca'), ('unique_20', 'default1', 'ca'), ('unique_21', 'unique_8', 'ca'), ('unique_22', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('ca',)
*/

-- Prediction Query
SELECT molecule.label FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE atom.element = 'ca' GROUP BY molecule.label ORDER BY COUNT(*) DESC, molecule.label NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/