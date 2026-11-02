-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__513b3e', 'molecule_i_1', 't3__da1c15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__a7a6da', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't3__da1c15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't3__da1c15');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '02eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'yu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'f8jegd2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'j4hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'nqcx5h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__94f992', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'z');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__3b638b', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', '4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'nrqrofqy');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__d641f4', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 't2__513b3e', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't2__513b3e', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'C', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a7a6da', 't2__513b3e', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 't2__a7a6da', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a7a6da', 'A', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_6', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a7a6da', 'G', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__513b3e', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_10', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'G', 't2__d641f4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 't2__d641f4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_11', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'O', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_10', 't2__d641f4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_12', 't2__d641f4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_13', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_14', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_15', 't2__d641f4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 't2__d641f4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_12', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_16', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_17', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_15', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_18', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__513b3e', 'atom_id_20', 't1__3b638b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_17', 't1__3b638b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__da1c15',)
('gu7v',)
('dpos',)
*/

-- Prediction Query
SELECT DISTINCT a.element FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id WHERE b.bond_type = '#' UNION SELECT DISTINCT a2.element FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_type = '#';

/*
Prediction Result:
('02eutliqa11r',)
('au2dwy',)
('dpos',)
('e',)
('f8jegd2',)
('gu7v',)
('j4hwbdvlph',)
('jsl',)
('lex',)
('nqcx5h',)
('qi2rkf9v',)
('t3__da1c15',)
('um5',)
('unw6klfa',)
('yu78',)
('z',)
*/