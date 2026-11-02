-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__8caaf2', 't1__735e7b', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__21bee5', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__ae909e', 'vfe4hria2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__ae909e', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__735e7b', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__735e7b', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'O', '0t5c4ecigce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__ae909e', 'm52zbu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__ae909e', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__ae909e', '02eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'G', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__ae909e', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__644495', 't1__735e7b', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'G', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__ae909e', 't1__d636e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'O', '5qi2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__735e7b', 'vqx58pz0f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__735e7b', 'd2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'G', '9uxj4hwbdvl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__735e7b', 'dqwn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 'A', '5hncprjtu0d');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__735e7b', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ae909e', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'puzhsrw');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '6klfa9');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'G', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'G', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 't1__735e7b', 't2__f22926');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't1__735e7b', 't2__64deea');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't1__735e7b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't1__735e7b', '=');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 't1__8caaf2', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_4', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 't1__21bee5', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't1__8caaf2', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_3', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_8', 'bond_id_7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_9', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_4', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'A', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'O', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'G', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_14', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_15', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 't3__644495', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 'A', 'bond_id_17');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_13', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_18', 'bond_id_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 't1__21bee5', 'bond_id_18');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 'atom_id_18', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_5', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_10', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 'atom_id_14', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 'atom_id_21', 'bond_id_13');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_22', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_23', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 'atom_id_24', 'bond_id_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__644495', 'atom_id_8', 'bond_id_23');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_25', 'bond_id_15');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8caaf2', 'atom_id_26', 'bond_id_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
('nprmdposii',)
('t1__d636e1',)
*/

-- Prediction Query
SELECT DISTINCT T2.element, T3.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id INNER JOIN atom AS T3 ON T1.atom_id2 = T3.atom_id INNER JOIN bond AS T4 ON T1.bond_id = T4.bond_id WHERE T4.bond_type = '=';

/*
Prediction Result:
('t1__d636e1', 't1__d636e1')
('t1__d636e1', 'vfe4hria2')
('t1__d636e1', 'hvdltt')
('nprmdposii', 't1__d636e1')
('nprmdposii', 'vfe4hria2')
('t1__d636e1', '0t5c4ecigce')
('t1__d636e1', 'm52zbu')
('nrqrofqy', 'hvdltt')
('nrqrofqy', 't1__d636e1')
('t1__d636e1', '02eutliqa11r')
('t1__d636e1', 'nprmdposii')
('nprmdposii', 'nprmdposii')
('nprmdposii', 'nrqrofqy')
('t1__d636e1', '9hl7')
('t1__d636e1', 'x1')
('t1__d636e1', 'dwyrq13pyu78')
('t1__d636e1', '5qi2')
('t1__d636e1', 'vqx58pz0f')
('t1__d636e1', 'd2')
('t1__d636e1', '9uxj4hwbdvl')
('t1__d636e1', 'dqwn')
('t1__d636e1', '5hncprjtu0d')
*/