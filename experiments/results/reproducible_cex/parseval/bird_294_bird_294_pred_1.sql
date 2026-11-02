-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__8eb38d', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__f6b20c', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 't2__f0fdca');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__f0fdca');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('F', 't2__f0fdca');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('E', NULL);

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__b59c24', 't1__8eb38d', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__8eb38d', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', 't1__d4d62c');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'D', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', '?', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'B', 't1__d4d62c');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('F', 'F', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 'E', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.bond_type = '=';

/*
Gold Result:
('t1__b59c24',)
('A',)
*/

-- Prediction Query
SELECT bond.bond_id FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND bond.bond_type = ' = ';

/*
Prediction Result:
*/