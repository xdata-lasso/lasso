-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__fcb81a', 'molecule_i_1', 't3__62cb8c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__5f4832', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', '5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'zbuo4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '72klex14ji7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'yrq13pyu78d9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'rkf9vqx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '8jegd21vy9ux');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'nqcx5h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'tu0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'gq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__2a2fa0', 'molecule_i_1', 'f3dqv0gc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'bilyrkn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__50abcc', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__9b24c4', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 't2__fcb81a', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5f4832', 't2__fcb81a', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 't2__5f4832', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__fcb81a', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't2__5f4832', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 't2__5f4832', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_6', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__5f4832', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', '_', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_7', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '_', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_7', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'G', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'A', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5f4832', 'A', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_9', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_10', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'G', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5f4832', 'atom_id_11', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', '_', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_12', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_13', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5f4832', 'atom_id_9', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_14', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_15', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_16', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5f4832', 'atom_id_7', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_17', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_18', 't2__9b24c4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__fcb81a', 'atom_id_20', 't1__50abcc');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5f4832', 'atom_id_17', 't1__50abcc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__62cb8c',)
('gu7v',)
('dpos',)
('5u',)
('p5s5bbp',)
*/

-- Prediction Query
SELECT T3.element FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '#';

/*
Prediction Result:
('t3__62cb8c',)
('gu7v',)
('dpos',)
('5u',)
('dpos',)
('dpos',)
('p5s5bbp',)
('dpos',)
('t3__62cb8c',)
('gu7v',)
('t3__62cb8c',)
('t3__62cb8c',)
('t3__62cb8c',)
('gu7v',)
('t3__62cb8c',)
('t3__62cb8c',)
('t3__62cb8c',)
('gu7v',)
('t3__62cb8c',)
('t3__62cb8c',)
('t3__62cb8c',)
('gu7v',)
('t3__62cb8c',)
('t3__62cb8c',)
('t3__62cb8c',)
('gu7v',)
*/