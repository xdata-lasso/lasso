-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_2_428', '+23', '+29');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+31', 'TR001_2_422', 'TR001_2_432');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'TR001_2_422', '+35');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+21', '+23', 'TR001_2_436');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_2_428', 'TR001_2_428', '+21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_2_428', '+31', '+21');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001_2_422', '+37');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+23', 'TR001_2_430');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_id = 'TR001_2_4';

/*
Gold Result:
('+37',)
*/

-- Prediction Query
SELECT T3.label FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T1.bond_id = 'TR001_2_4' AND T3.label = '+';

/*
Prediction Result:
*/