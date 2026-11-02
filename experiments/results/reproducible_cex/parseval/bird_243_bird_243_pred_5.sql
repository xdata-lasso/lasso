-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__5ca878', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__5b3dab', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__386bdc', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__895b5a', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'fa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__7b5629', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'qyp5s5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'a11ry');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'oo3o9hl72kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'i7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', '2dwyrq13pyu7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'l0b4y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'i2rkf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'z0f8jegd21vy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', 'j4hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', 'qcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'molecule_i_1', '79fjgq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 'molecule_i_1', 'f3dqv0gc');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__16740d', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_1', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 't3__386bdc', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 't1__5ca878', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__895b5a', 'atom_id_1', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__386bdc', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 't1__5b3dab', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_9', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_10', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_12', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't3__895b5a', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'O', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_10', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__5b3dab', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'O', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_9', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'C', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_1', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', '_', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 't2__7b5629', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'G', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'A', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_15', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_16', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_15', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_10', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_17', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_18', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_19', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_12', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_20', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_21', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_20', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_22', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_20', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_21', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_18', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_23', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_24', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7b5629', 'atom_id_15', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_25', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_26', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5ca878', 'atom_id_27', 't2__16740d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__386bdc', 'atom_id_28', 't2__16740d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
('t2__16740d',)
*/

-- Prediction Query
SELECT DISTINCT c.bond_id FROM connected AS c INNER JOIN atom AS a1 ON c.atom_id = a1.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE a1.element = 'p' AND a2.element = 'n';

/*
Prediction Result:
('t2__16740d',)
*/