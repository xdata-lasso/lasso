-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'TR005'), ('TR001', NULL), ('default2', NULL), ('TR005', 'default1'), ('unique_4', 'TR001'), ('unique_5', 'default2'), ('unique_6', 'TR005'), ('unique_7', 'TR001'), ('unique_8', 'TR005'), ('unique_9', 'default2'), ('unique_10', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default2', 'TR001'), ('default1', 'default1', 'default1'), ('TR005', NULL, 'default1'), ('TR001', 'TR001', 'default1'), ('unique_4', 'unique_6', 'default1'), ('unique_5', 'unique_5', 'TR005'), ('unique_6', 'default1', 'default1'), ('unique_7', 'default1', 'default2'), ('unique_8', 'unique_6', 'default1'), ('unique_9', 'default2', 'default2'), ('unique_10', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.atom_id) FROM atom AS T WHERE T.molecule_id = 'TR005';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT("atom_id") FROM "atom" WHERE "molecule_id" = 'TR001';

/*
Prediction Result:
(1,)
*/