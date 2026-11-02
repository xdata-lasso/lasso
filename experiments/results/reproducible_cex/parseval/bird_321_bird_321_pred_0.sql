-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 't1__61ce2b', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_4', 't1__61ce2b', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__051b75', 't1__61ce2b', 'gce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__f8361d', 't1__61ce2b', '6nium52zb');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__61ce2b', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__2c9edc', 't1__61ce2b', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__61ce2b', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__61ce2b', 'hvdlttilbnpr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 't1__61ce2b', 'dposiie5unw');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 't1__61ce2b', 'fa9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__da4503', 't1__61ce2b', '00t5c4e');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'TR000_4', 't1__2c9edc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__051b75', 'TR000_4', 't1__2c9edc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 't2__f8361d', 't1__2c9edc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__051b75', 't2__f8361d', 't2__da4503');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Gold Result:
('t1__61ce2b',)
*/

-- Prediction Query
SELECT T3.label FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T1.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Prediction Result:
('5k5swwqcgs',)
*/