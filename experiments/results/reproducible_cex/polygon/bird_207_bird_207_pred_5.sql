-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=22', '=24', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=25', '=24', '=32');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=36', '=35', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=23', '=24', '=31');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=22', '=25', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=22', '=22', '=36');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=35', '=22');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=24', '=22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT t3.element FROM bond AS t1 INNER JOIN connected AS t2 ON t1.bond_id = t2.bond_id INNER JOIN atom AS t3 ON t2.atom_id = t3.atom_id WHERE t1.bond_type = '=';

/*
Prediction Result:
(None,)
*/