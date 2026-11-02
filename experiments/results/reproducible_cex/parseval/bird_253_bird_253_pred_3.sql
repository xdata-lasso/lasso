-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__dcc010', 'molecule_i_1', 't3__505e9a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 't3__505e9a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', '5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 't3__505e9a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'gce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '02eu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('''', 'molecule_i_1', 't3__505e9a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '7zwau2dwyr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '3pyu78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__9086d2', 'molecule_i_1', 'x58pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__3a1f19', 'molecule_i_1', '9uxj4hw');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__31b372', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c696a3', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 't2__dcc010', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't2__dcc010', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'C', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'C', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't2__dcc010', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'G', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', '_', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '_', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'O', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', '?', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'A', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '?', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_9', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'atom_id_10', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't2__dcc010', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_11', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'Q', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('''', 'C', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '''', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'atom_id_13', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_14', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'atom_id_15', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'atom_id_16', 't2__c696a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dcc010', 'atom_id_14', 't1__31b372');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3a1f19', 't2__dcc010', 't1__31b372');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__505e9a',)
('gu7v',)
('dpos',)
('5u',)
('gce',)
('luhvdltti',)
('9uxj4hw',)
*/

-- Prediction Query
SELECT a.element FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id WHERE b.bond_type = '#';

/*
Prediction Result:
('t3__505e9a',)
('gu7v',)
('dpos',)
('5u',)
('dpos',)
('5u',)
('dpos',)
('gce',)
('t3__505e9a',)
('luhvdltti',)
('dpos',)
('luhvdltti',)
('t3__505e9a',)
('luhvdltti',)
('dpos',)
('luhvdltti',)
('t3__505e9a',)
('luhvdltti',)
('t3__505e9a',)
('luhvdltti',)
('t3__505e9a',)
('luhvdltti',)
('t3__505e9a',)
('t3__505e9a',)
('t3__505e9a',)
('9uxj4hw',)
*/