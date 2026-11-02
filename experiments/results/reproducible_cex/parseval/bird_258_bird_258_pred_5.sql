-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__5fc5c9', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'ypuzhsrw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'e5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'cigce376nium');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'hl72klex1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__ba3524', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'z0f8jegd21vy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'h2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'nqcx5h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'u0dz7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'gq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'dqv0gcb9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'n6vck6ah0f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'wwlq7');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't3__a7be04');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 'u7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 't3__a7be04');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't3__a7be04');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'dpos');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 't3__a7be04');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', 'qa1');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 't3__a7be04');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__12b15b', 'molecule_i_1', '3zb');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 't1__5fc5c9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_2', 'C');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 't1__5fc5c9', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_5', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_6', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_7', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_5', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', '@', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_10', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_11', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_10', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_13', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_14', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_7', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_15', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_9', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_16', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_16', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', '@', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_17', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_18', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_19', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_20', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_21', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ba3524', 'atom_id_18', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_22', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5fc5c9', 'atom_id_23', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
('t3__a7be04',)
('u7',)
('dpos',)
('qa1',)
*/

-- Prediction Query
SELECT T2.bond_type FROM atom AS T1 INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id INNER JOIN bond AS T2 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Prediction Result:
('t3__a7be04',)
('u7',)
('dpos',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('qa1',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('dpos',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('t3__a7be04',)
('dpos',)
('t3__a7be04',)
*/