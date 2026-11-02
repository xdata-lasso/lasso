-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__9473b8', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'ryytoo3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '72k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'i7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', '8d99rljsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'f8jegd21vy9u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'nqcx5h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'rjtu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'gq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', '3d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', 'gcb98oz');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__269b80', 'molecule_i_1', 'yrkn6vck6ah0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'molecule_i_1', 'q7x');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 'molecule_i_1', 'xa');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__599494');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__1e9d18', 'molecule_i_1', 't1__599494');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't1__599494');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 'ia2yp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 't1__599494');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 't1__599494');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 't1__599494');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 't1__599494');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 't2__9473b8', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_2', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_3', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_4', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_2', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_3', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', '?', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_10', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_11', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', '@', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'A', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_12', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_13', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_14', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', '@', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_15', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_16', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_17', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'a', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_18', 'C');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_19', 'C');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_20', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_21', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_22', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_23', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_24', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_25', 'C');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_27', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9473b8', 'atom_id_28', 'O');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
('t1__599494',)
('ia2yp',)
*/

-- Prediction Query
SELECT DISTINCT bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id OR atom.atom_id = connected.atom_id2 INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'cl';

/*
Prediction Result:
*/