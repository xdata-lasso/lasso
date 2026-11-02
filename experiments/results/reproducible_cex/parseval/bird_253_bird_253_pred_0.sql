-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__62c15a', 'molecule_i_1', 't3__7a4119');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__819a88', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't3__7a4119');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'gce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'zbuo4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', '5s5b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'ryytoo3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '2dwyrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '9rljsl0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'kf9vq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'y9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'lph2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'qcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__56aa1b', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', '9fjgq8n2f');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__d72cc6', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__b21211', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 't2__62c15a', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't2__62c15a', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'C', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__819a88', 't2__62c15a', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'C', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_6', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 't2__819a88', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__819a88', 'A', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'A', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_8', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__819a88', 'O', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't2__62c15a', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'A', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_6', 't2__b21211');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 't2__b21211');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_10', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'A', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_11', 't2__b21211');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 't2__b21211');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_12', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', '_', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_13', 't2__b21211');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '_', 't2__b21211');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_14', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_15', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_16', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_17', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_18', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__62c15a', 'atom_id_20', 't1__d72cc6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_15', 't1__d72cc6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__7a4119',)
('gu7v',)
('dpos',)
('gce',)
('5s5b',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#';

/*
Prediction Result:
('t3__7a4119',)
('gu7v',)
('dpos',)
('dpos',)
('gce',)
('dpos',)
('5s5b',)
('dpos',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
('t3__7a4119',)
*/