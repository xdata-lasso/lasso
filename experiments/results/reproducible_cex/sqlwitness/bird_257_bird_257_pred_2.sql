-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('s', 'default2'), ('default2', NULL), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_3', NULL), ('s', 's', 'default1'), ('default2', 's', 'default1'), ('unique_3', 'unique_5', 'default2'), ('unique_4', 'unique_4', 'default2'), ('unique_5', 'default2', 'default2'), ('unique_6', NULL, 'default2'), ('unique_7', 'default2', 's'), ('unique_8', 'unique_3', 'default1'), ('unique_9', NULL, 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('s', 'unique_4', 's'), ('default1', NULL, 's');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 's', 'default2'), ('s', 's', 'unique_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('s',)
*/

-- Prediction Query
SELECT "connected"."atom_id2" FROM "connected" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" WHERE "atom"."element" = 's';

/*
Prediction Result:
('s',)
('s',)
*/