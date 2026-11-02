-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__2b376f', 'molecule_i_1', 't3__fab98f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__c0d5a2', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't3__fab98f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'ytoo3o9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '4ji7zwa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'q13py');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '9rljsl0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'lph2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'u0dz7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__aea8a0', 'molecule_i_1', 'gq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'qv0gcb98ozk');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__f30174', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__4bd11f', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 't2__2b376f', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 't2__2b376f', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 't2__c0d5a2', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'atom_id_3', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't2__c0d5a2', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_6', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 't2__c0d5a2', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'A', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'A', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_8', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'atom_id_9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'G', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_12', 't2__4bd11f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'atom_id_6', 't2__4bd11f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_13', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_14', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_15', 't2__4bd11f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'atom_id_13', 't2__4bd11f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'Q', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_16', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_17', 't2__4bd11f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'atom_id_18', 't2__4bd11f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'G', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_9', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'A', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'G', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_19', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2b376f', 'atom_id_21', 't1__f30174');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c0d5a2', 'atom_id_15', 't1__f30174');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__fab98f',)
('gu7v',)
('rmdp',)
('um5',)
('liqa1',)
*/

-- Prediction Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#' UNION SELECT DISTINCT T5.element FROM bond AS T4 INNER JOIN connected AS T6 ON T4.bond_id = T6.bond_id INNER JOIN atom AS T5 ON T6.atom_id2 = T5.atom_id WHERE T4.bond_type = '#';

/*
Prediction Result:
('2rk',)
('4ji7zwa',)
('8pz0f8je',)
('9000t5c4ec',)
('9rljsl0b4',)
('9uxj4hw',)
('gu7v',)
('liqa1',)
('lph2gn',)
('p5s5bbp',)
('q13py',)
('qv0gcb98ozk',)
('rmdp',)
('t3__fab98f',)
('um5',)
('ytoo3o9hl7',)
*/