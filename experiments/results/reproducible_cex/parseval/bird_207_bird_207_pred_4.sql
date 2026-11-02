-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6ffbf3', 't1__c7b232', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6256da', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__ad48be', 'vfe4hria2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__ad48be', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__c7b232', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__c7b232', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'O', 'c4ecigce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__ad48be', 'm52zbu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__c7b232', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__ad48be', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'C', '2eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'C', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__ad48be', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__711b5e', 't1__c7b232', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'A', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'O', 'yrq13pyu78d9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__ad48be', 't1__d5af43');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'A', '5qi2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'O', 'x58pz');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__c7b232', '8jegd21vy9ux');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__c7b232', 'bdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't1__ad48be', 'q');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__c7b232', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ad48be', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'puzhsrw');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'p6luhvdlttil');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 't1__c7b232', 't2__473e65');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't1__c7b232', 't2__932b6d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't1__c7b232', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't1__c7b232', '=');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 't1__6ffbf3', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_4', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 't1__6256da', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_4', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_8', 'bond_id_7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_9', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_12', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_13', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'A', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_15', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_16', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'atom_id_16', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'O', 'bond_id_17');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_19', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_20', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'atom_id_17', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'atom_id_5', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'I', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_14', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'atom_id_23', 'bond_id_13');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'atom_id_9', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_24', 'bond_id_18');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_25', 'bond_id_23');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__711b5e', 'atom_id_26', 'bond_id_16');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_27', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6ffbf3', 'atom_id_12', 'bond_id_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
('unw6klfa',)
('t1__d5af43',)
*/

-- Prediction Query
SELECT T2.element FROM bond AS T1 JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=';

/*
Prediction Result:
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('5qi2',)
('u',)
('5qi2',)
('u',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('5qi2',)
('u',)
('5qi2',)
('u',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('5qi2',)
('u',)
('5qi2',)
('u',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
('8jegd21vy9ux',)
('bdvlph',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('t1__d5af43',)
('unw6klfa',)
*/