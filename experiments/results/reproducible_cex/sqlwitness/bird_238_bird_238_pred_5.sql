-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', '#'), ('default1', 'default2'), ('default2', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default2', 'default1'), ('default1', 'default1', '#'), ('#', 'default2', 'default1'), ('unique_3', 'default1', 'default1'), ('unique_4', '#', '#'), ('unique_5', NULL, '#'), ('unique_6', 'default2', 'default2'), ('unique_7', 'default1', 'default2'), ('unique_8', 'default1', 'default2'), ('unique_9', 'default2', '#'), ('unique_10', 'default2', 'default1'), ('unique_11', NULL, '#'), ('unique_12', '#', '#'), ('unique_13', '#', 'default2'), ('unique_14', NULL, NULL), ('unique_15', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.molecule_id) FROM bond AS T WHERE T.bond_type = '#';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(molecule_id) FROM bond WHERE bond_type = '#';

/*
Prediction Result:
(4,)
*/