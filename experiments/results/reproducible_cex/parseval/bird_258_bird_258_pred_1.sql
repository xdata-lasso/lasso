-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__4b5d8f', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'ypuzhsrw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'qa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'o3o9hl72klex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'i7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__91377e', 'molecule_i_1', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '3pyu78d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'dqwn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'dz79fjg');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'dqv0gcb9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'h0f8jswwlq');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__e91ceb', 'molecule_i_1', 't3__7d63df');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 'u7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'fqyp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__c7b74b', 'molecule_i_1', 'k3zbily');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 't1__4b5d8f', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_2', 'C');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 't1__4b5d8f', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_5', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_5', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_6', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'A', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_2', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_7', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_8', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_9', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_10', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_11', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 't2__91377e', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'atom_id_8', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_13', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'atom_id_5', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_14', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_15', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'atom_id_15', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_16', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_17', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_18', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_19', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'atom_id_9', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__91377e', 'atom_id_20', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_21', 't2__e91ceb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b5d8f', 'atom_id_22', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
('t3__7d63df',)
('u7',)
('posiie5unw6k',)
('a9000t5c4eci',)
('fqyp',)
('luhvdltti',)
*/

-- Prediction Query
SELECT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'sn';

/*
Prediction Result:
('t3__7d63df',)
('u7',)
('posiie5unw6k',)
('a9000t5c4eci',)
('posiie5unw6k',)
('fqyp',)
('fqyp',)
('posiie5unw6k',)
('t3__7d63df',)
('luhvdltti',)
('posiie5unw6k',)
('luhvdltti',)
('t3__7d63df',)
('luhvdltti',)
('fqyp',)
('luhvdltti',)
('t3__7d63df',)
('luhvdltti',)
('posiie5unw6k',)
('luhvdltti',)
('t3__7d63df',)
('luhvdltti',)
('a9000t5c4eci',)
('posiie5unw6k',)
('t3__7d63df',)
('luhvdltti',)
*/