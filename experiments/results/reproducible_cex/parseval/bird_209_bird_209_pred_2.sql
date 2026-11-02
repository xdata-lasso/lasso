-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__ad80a0', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', '5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'm52zbu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'rofqyp5s5b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'oo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '72klex14ji7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', '9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'lph2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'x');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', '9fjgq8n2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'qv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', 'lyr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', '6vck6ah0f8js');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__ec6abd', 'molecule_i_1', 'lq7xb7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'molecule_i_1', 'fdrz16n');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'ia2yp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'molecule_i_1', 't1__d4894f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 't1__d4894f');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 't2__ad80a0', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_2', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_3', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_4', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_2', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'A', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_7', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', '@', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_7', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_3', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', '?', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_9', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_10', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 't2__ad80a0', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_10', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_11', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_12', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_13', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_14', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_15', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_16', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_17', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_18', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_19', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_20', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_21', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_22', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_23', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_24', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_25', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'atom_id_27', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ad80a0', 'A', 'O');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
('t1__d4894f',)
('ia2yp',)
*/

-- Prediction Query
SELECT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'Te';

/*
Prediction Result:
*/