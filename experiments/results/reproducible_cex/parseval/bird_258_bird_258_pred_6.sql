-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__544fda', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'ypuzhsrw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'e5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'fqyp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '02eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'hl72klex1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__102744', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'z0f8jegd21vy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'j4hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'qcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'tu0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', '9fjgq8n2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'gcb98ozk3z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'yrk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'k');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__8d2560', 'molecule_i_1', 't3__f00b69');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__f3dc1a', 'molecule_i_1', 'u7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't3__f00b69');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', 'dpos');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'klfa9000t');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', '52zbuo4nrq');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__0048cb', 'molecule_i_1', 'h0f8jswwlq');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 't1__544fda', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_2', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 't1__544fda', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_5', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_6', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_7', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_6', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_8', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_9', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_10', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_7', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', '@', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_11', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_10', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_9', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_13', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_14', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_7', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_15', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_16', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_17', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_2', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_18', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_19', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_20', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_21', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'atom_id_22', 't2__f3dc1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_20', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__102744', 'atom_id_23', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 'A', 't2__8d2560');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__544fda', 't2__102744', 't2__f3dc1a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
('t3__f00b69',)
('u7',)
('dpos',)
('klfa9000t',)
('52zbuo4nrq',)
*/

-- Prediction Query
SELECT bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'sn';

/*
Prediction Result:
('t3__f00b69',)
('u7',)
('dpos',)
('klfa9000t',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('t3__f00b69',)
('u7',)
('t3__f00b69',)
('t3__f00b69',)
('t3__f00b69',)
('u7',)
('t3__f00b69',)
('t3__f00b69',)
('t3__f00b69',)
('u7',)
('t3__f00b69',)
('t3__f00b69',)
('t3__f00b69',)
('u7',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('t3__f00b69',)
('u7',)
*/