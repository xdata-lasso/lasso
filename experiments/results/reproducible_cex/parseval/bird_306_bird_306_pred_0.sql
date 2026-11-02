-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__7498dc', 't2__da1f55');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__7498dc', 't2__da1f55');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'A', 't2__da1f55');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'A', 't2__da1f55');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__7498dc', 't2__da1f55');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__7498dc', 't2__da1f55');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', '@', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 't1__7498dc', 'tti');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__7498dc', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__7498dc', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__7498dc', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', '@', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', '@', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't1__7498dc', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', '@', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', 'e4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 't1__7498dc', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t1__7498dc', 't2__da1f55')
('t1__7498dc', 'tti')
('@', 'hria2ypuzhs')
('@', 'rwbbp6luhvd')
*/

-- Prediction Query
SELECT T3.label, T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id INNER JOIN bond AS T4 ON T2.bond_id = T4.bond_id WHERE T4.bond_type = '#' GROUP BY T3.label, T1.element;

/*
Prediction Result:
*/