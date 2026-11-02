-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te20', 'c21', 'c19');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c19', 'c21', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te30', 'c29', 'c31');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te22', NULL, 'c19');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te20', 'te20', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c19', 'c19', 'te30');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('c29', 'c19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('c21', 'c19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT b.bond_type FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id WHERE a.element = 'c';

/*
Prediction Result:
('c31',)
*/