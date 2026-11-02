-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR06022', 'TR060', 'TR06024');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR06023', 'TR060', 'TR06024');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR06017', 'TR06015', 'TR060');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR06016', 'TR06015', 'TR060');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR06022', 'TR06022', 'TR06017');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR06015', 'TR060');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR060', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR060';

/*
Gold Result:
('TR06024', None)
*/

-- Prediction Query
SELECT T1.element, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR060';

/*
Prediction Result:
('TR06024', None)
('TR06024', None)
*/