-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_3_429', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_3_416', NULL, 'TR001_3_424');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_3_4', 'TR001_3_418', 'TR001_3_416');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_3_432', 'TR001_3_418', 'TR001_3_416');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_3_429', 'TR001_3_416', 'TR001_3_4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_3_416', 'TR001_3_416', 'TR001_3_432');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001_3_417', 'TR001_3_416');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001_3_418', 'TR001_3_416');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT COALESCE(atom1.element, atom2.element)) AS unique_elements FROM connected INNER JOIN atom AS atom1 ON connected.atom_id = atom1.atom_id INNER JOIN atom AS atom2 ON connected.atom_id2 = atom2.atom_id WHERE connected.bond_id = 'TR001_3_4';

/*
Prediction Result:
(1,)
*/