-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__ab8fb5', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'oo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '7zw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '8d99rljsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', '9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'lph2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'x');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', '9fjgq8n2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'qv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__9f9502', 'molecule_i_1', 'bilyrkn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', 'k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 'molecule_i_1', 'wwlq7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'molecule_i_1', '7');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__14d339', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'ia2yp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__786d3a', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__5da6aa', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'molecule_i_1', 't1__46415d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'molecule_i_1', 't1__46415d');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 't2__ab8fb5', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_2', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_3', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_4', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_2', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'A', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_8', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_8', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_4', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_9', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', '@', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', '@', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_10', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_11', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_12', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_13', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_14', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_15', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_16', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_17', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_18', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_19', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_20', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_21', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_22', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_23', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_25', 't2__5da6aa');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_26', 't1__14d339');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ab8fb5', 'atom_id_27', 't1__14d339');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
('t1__46415d',)
('ia2yp',)
*/

-- Prediction Query
SELECT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl';

/*
Prediction Result:
*/