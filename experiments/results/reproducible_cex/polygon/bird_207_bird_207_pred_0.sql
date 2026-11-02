-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('double31', 'double29', '=30');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=32', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=20', 'double21', 'double');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('double19', 'double29', '=26');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=32', '=32', '=20');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('double31', 'double31', 'double19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('double21', 'double31');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('double29', 'double31');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT atom.element FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = 'double';

/*
Prediction Result:
(None,)
*/