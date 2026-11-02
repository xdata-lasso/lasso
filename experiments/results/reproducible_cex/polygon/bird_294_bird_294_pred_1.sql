-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=13', NULL, '=19');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+12', ' = 14', '=19');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES (' = 20', '=19', ' = ');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+21', '=19', ' = ');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+12', '=13', '+21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+12', '+12', ' = 20');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=19', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES (' = 14', '=19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT bond.bond_id FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND bond.bond_type = ' = ';

/*
Prediction Result:
(' = 20',)
('+21',)
*/