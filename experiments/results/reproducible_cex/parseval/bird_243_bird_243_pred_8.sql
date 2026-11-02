-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__4f8fc7', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6bd291', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__163159', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__2271f4', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__8f69da', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'oo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'f8jegd21vy9u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'wnqcx');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'rjtu');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__d3b807', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'atom_id_1', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 't3__163159', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 't1__4f8fc7', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2271f4', 'atom_id_1', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__163159', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 't1__6bd291', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 't3__2271f4', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_1', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'atom_id_9', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'G', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'Q', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'O', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'O', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'G', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_13', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 't2__8f69da', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 'G', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_15', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'A', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_16', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_1', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'C', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'C', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 't3__163159', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 'atom_id_16', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 't3__2271f4', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 't3__2271f4', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 't1__4f8fc7', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_17', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_18', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 'atom_id_19', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 'atom_id_9', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', '?', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'atom_id_19', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_20', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'atom_id_16', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_21', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 'O', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__8f69da', 'Q', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'atom_id_22', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 'atom_id_22', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4f8fc7', 'atom_id_23', 't2__d3b807');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__163159', 't2__8f69da', 't2__d3b807');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
('t2__d3b807',)
*/

-- Prediction Query
SELECT DISTINCT c.bond_id FROM connected AS c JOIN atom AS a1 ON c.atom_id = a1.atom_id AND a1.element = 'p' JOIN atom AS a2 ON c.atom_id2 = a2.atom_id AND a2.element = 'n' WHERE c.bond_id IN (SELECT bond_id FROM bond);

/*
Prediction Result:
('t2__d3b807',)
*/