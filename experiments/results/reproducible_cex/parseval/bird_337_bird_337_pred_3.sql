-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR016', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'TR016', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR016', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR016', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR016', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__86ce34', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 'TR016', 't1__344f15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'A', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'A', 'hria2ypuzhs');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR016', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__86ce34', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__fa00c0', 'gu7v');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'TR016', 't2__7e6876');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR016', 't2__7e6876');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'A', 't2__7e6876');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'A', 't2__7e6876');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'A', 't2__7e6876');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'TR016', 't2__7e6876');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'A', 'rwbbp6luhvd');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'A', 'tti');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('t1__344f15', 't2__7e6876')
*/

-- Prediction Query
SELECT atom.element, bond.bond_type FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE molecule.molecule_id = 'TR002';

/*
Prediction Result:
*/