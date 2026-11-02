-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', 'default1'), ('default2', 'default1'), ('default1', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'TR000', 'TR000'), ('TR000', 'default2', 'default2'), ('default1', 'default1', NULL), ('unique_3', 'TR000', 'default1'), ('unique_4', 'default1', 'TR000'), ('unique_5', 'default1', 'TR000'), ('unique_6', NULL, 'TR000'), ('unique_7', 'default2', 'default1'), ('unique_8', 'default2', NULL), ('unique_9', 'default2', NULL), ('unique_10', 'TR000', 'TR000'), ('unique_11', 'default2', 'default1'), ('unique_12', NULL, 'TR000'), ('unique_13', 'default2', 'default1'), ('unique_14', 'default2', 'default2'), ('unique_15', 'TR000', NULL), ('unique_16', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR000' ORDER BY T.element LIMIT 3;

/*
Gold Result:
(None,)
('TR000',)
('default1',)
*/

-- Prediction Query
SELECT element FROM atom WHERE molecule_id = 'TR000' ORDER BY element ASC, atom.atom_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(None,)
('TR000',)
('TR000',)
*/