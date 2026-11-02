-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA45A', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAAAAA45A', 'molecule_i_1', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA!AAA45A', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'fa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', '5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('WAAAAA45A', 'molecule_i_1', 'gce376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('IAAAAA45A', 'molecule_i_1', 'uo4nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAAAAAAAA', 'molecule_i_1', 'tliqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__3a6b5d', 'molecule_i_1', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('WA!AAA45A', 'molecule_i_1', 'x1');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__d14fcd', 'molecule_i_1', 't1__5442fb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__5442fb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'b');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'n');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__ef3b66', 'molecule_i_1', 't1__5442fb');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('AAAAAA45A', 'AAAAAA45A', 't1__d14fcd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'OAAAAA45A', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA!AAA45A', 'AAAAAA45A', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'atom_id_4', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'atom_id_5', 't2__ef3b66');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('WAAAAA45A', 'WAAAAA45A', 't2__ef3b66');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('IAAAAA45A', 'OAAAAA45A', 't2__ef3b66');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA!AAA45A', 'atom_id_4', 't2__ef3b66');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'atom_id_8', 't2__ef3b66');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'IAAAAA45A', 't2__ef3b66');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAAAAA', 'IAAAAA45A', 't1__d14fcd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3a6b5d', 'OAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3a6b5d', 'OAAAAAAAA', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('WA!AAA45A', 'atom_id_8', 't1__d14fcd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE SUBSTRING(T2.atom_id, 7, 2) = '45';

/*
Gold Result:
('t1__5442fb', 't1__d14fcd')
('b', 'G')
('n', 'O')
('dposiie5unw', '_')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't1__d14fcd')
*/

-- Prediction Query
SELECT B."bond_type", B."bond_id" FROM "bond" AS B INNER JOIN "connected" AS C ON B."bond_id" = C."bond_id" WHERE SUBSTRING(C."atom_id", 7, 2) + 0 = 45 OR SUBSTRING(C."atom_id2", 7, 2) + 0 = 45;

/*
Prediction Result:
('t1__5442fb', 't1__d14fcd')
('b', 'G')
('n', 'O')
('dposiie5unw', '_')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't2__ef3b66')
('t1__5442fb', 't1__d14fcd')
('t1__5442fb', 'A')
('t1__5442fb', 't1__d14fcd')
*/