-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 't1__961f90', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_4', 't1__961f90', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__5446f4', 't1__961f90', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__0d6f4f', 't1__961f90', 'nrqrofqy');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__961f90', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__89459f', 't1__961f90', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__961f90', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__961f90', 'hvdlttilbnpr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't1__961f90', 'dposiie5unw');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't1__961f90', 'fa9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 't1__961f90', '00t5c4ecigc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__0b98e1', 't1__961f90', 'e376nium52');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'TR000_4', 't1__89459f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5446f4', 'TR000_4', 't1__89459f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 't2__0d6f4f', 't1__89459f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5446f4', 't2__0d6f4f', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Gold Result:
('t1__961f90',)
*/

-- Prediction Query
SELECT molecule_id FROM atom WHERE atom_id IN ('TR000_2', 'TR000_4');

/*
Prediction Result:
('t1__961f90',)
('t1__961f90',)
*/