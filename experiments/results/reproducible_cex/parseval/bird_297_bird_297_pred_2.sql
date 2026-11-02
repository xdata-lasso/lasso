-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__45b6fe', 't1__1fd21f', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__1fd21f', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__a72e39', 't1__1fd21f', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__1fd21f', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'B', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'H', 't1__edabae');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', '"', 't1__edabae');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', '#', 't1__edabae');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1fd21f', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__a80e8d', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__dbea18');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('"', 't2__dbea18');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('t1__45b6fe',)
('O',)
('t1__a72e39',)
('_',)
*/

-- Prediction Query
SELECT atom.atom_id FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE atom.element = 'c' AND molecule.label = '-';

/*
Prediction Result:
*/