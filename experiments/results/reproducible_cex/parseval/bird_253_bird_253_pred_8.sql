-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__c4985c', 'molecule_i_1', 't3__257300');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__f91547', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 't3__257300');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't3__257300');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '5s5b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '02eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '3pyu78d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'b4yp5qi');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'x58pz');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'gd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__05d363', 'molecule_i_1', 'v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'dqwn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__4a4a3c', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c371dd', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 't2__c4985c', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f91547', 't2__c4985c', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 't2__f91547', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__f91547', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', '_', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't2__c4985c', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', '_', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'A', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'G', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__c4985c', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_7', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_8', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'O', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f91547', 'O', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_9', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_10', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'A', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f91547', 'A', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', '_', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_11', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_12', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f91547', 'atom_id_13', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_14', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_8', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_15', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f91547', 'atom_id_7', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_16', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_17', 't2__c371dd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c4985c', 'atom_id_19', 't1__4a4a3c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f91547', 'atom_id_9', 't1__4a4a3c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__257300',)
('gu7v',)
('dposiie5unw',)
*/

-- Prediction Query
SELECT DISTINCT "atom"."element" FROM "atom" INNER JOIN "connected" ON "atom"."atom_id" = "connected"."atom_id" OR "atom"."atom_id" = "connected"."atom_id2" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" WHERE "bond"."bond_type" = '#';

/*
Prediction Result:
('t3__257300',)
('gu7v',)
('dposiie5unw',)
('luhvdltti',)
('76nium52',)
('u',)
('5s5b',)
('02eutliqa11r',)
('lex',)
('au2dwy',)
('3pyu78d',)
('b4yp5qi',)
('x58pz',)
('gd',)
('9uxj4hw',)
('dqwn',)
*/