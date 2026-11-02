-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__b686a8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 't1__b686a8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't1__b686a8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 't1__b686a8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't1__b686a8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 't1__b686a8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__672d85', 'molecule_i_1', 'qa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__80af2a', 'molecule_i_1', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'lex');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c5489c', 'molecule_i_1', 'fqyp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c51670', 'molecule_i_1', 'bbp02eut');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_5', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_7', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_9', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'A', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_11', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'I', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'G', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'O', 't2__c5489c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'I', 't2__c51670');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__80af2a', 'I', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', '_', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_15', 'TR001_2_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
('t1__b686a8',)
('yytoo',)
*/

-- Prediction Query
SELECT DISTINCT t2.element FROM connected AS t1 INNER JOIN atom AS t2 ON t1.atom_id = t2.atom_id OR t1.atom_id2 = t2.atom_id WHERE t1.bond_id = 'TR001_2_4';

/*
Prediction Result:
('t1__b686a8',)
('a2y',)
('rwbbp6luhvd',)
('bnp',)
('dposiie5unw',)
('00t5c4ecigc',)
('um5',)
('yytoo',)
('lex',)
*/