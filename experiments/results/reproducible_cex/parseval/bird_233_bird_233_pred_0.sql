-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__2bbd97', 'TR006', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b1a8e0', 'TR006', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'TR006', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR006', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR006', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR006', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR006', 'a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__6ef0d5', 'TR006', '0t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'TR006', 'zbuo4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'TR006', 'qyp5s5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__e44464', '72klex14ji7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__eed7e6', '2dwyrq13pyu7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__e44464', 'rljsl0b4y');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__eed7e6', '2eutliqa11r');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__e44464', 'ytoo3o9');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__b0ac88', 'TR006', 'u7vfe4hria2y');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2bbd97', 't1__2bbd97', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2bbd97', 'atom_id_3', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 't1__b1a8e0', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_3', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', '_', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__b1a8e0', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'A', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'G', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'A', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'O', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 't1__b1a8e0', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 't2__6ef0d5', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'A', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'atom_id_3', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'G', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'atom_id_9', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', '_', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'atom_id_10', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2bbd97', 't1__b1a8e0', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2bbd97', 'atom_id_11', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'atom_id_12', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__6ef0d5', 'atom_id_13', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2bbd97', 'atom_id_10', 't2__b0ac88');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2bbd97', 't2__6ef0d5', 't2__b0ac88');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.molecule_id = 'TR006' ORDER BY T2.bond_id LIMIT 2;

/*
Gold Result:
('t2__b0ac88',)
*/

-- Prediction Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006' ORDER BY T1.bond_type ASC, T1.bond_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 2;

/*
Prediction Result:
('u7vfe4hria2y',)
*/