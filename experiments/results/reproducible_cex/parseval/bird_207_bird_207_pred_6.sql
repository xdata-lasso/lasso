-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__08b4ef', 't1__135629');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__2edaa9', 't1__135629');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__2edaa9', 'vfe4hria2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'A', 't1__135629');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__08b4ef', 't1__135629');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__2edaa9', 'tilbn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__08b4ef', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', '?', '0t5c4ecigce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', '?', 'ium5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'O', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', '?', 'too3o9h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__08b4ef', 't1__135629');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__2edaa9', '7zw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 't1__08b4ef', 't1__135629');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'C', 'q13py');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__8e69d8', '?', '9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'A', '0b4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__08b4ef', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__2edaa9', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'puzhsrw');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 'dpos');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'zbuo4nrq');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'C', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'C', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', '?', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', '?', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 't1__08b4ef', 't2__4841ad');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't1__08b4ef', 't2__7172b4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't1__08b4ef', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't1__08b4ef', '=');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_7', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'O', 'bond_id_7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'bond_id_7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'C', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 'bond_id_7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_10', 'bond_id_16');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_7', 'bond_id_14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 'bond_id_13');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_3', 'bond_id_17');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_8', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_3', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', '_', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_13', 'bond_id_16');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_10', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_6', 'bond_id_23');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('E', 'atom_id_8', 'bond_id_23');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('E', 'A', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_15', 'bond_id_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_6', 'bond_id_17');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__8e69d8', 'atom_id_9', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_17', 'bond_id_29');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_13', 'bond_id_20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
('t1__135629',)
('9',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '=';

/*
Prediction Result:
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('t1__135629',)
('9',)
('t1__135629',)
('t1__135629',)
*/