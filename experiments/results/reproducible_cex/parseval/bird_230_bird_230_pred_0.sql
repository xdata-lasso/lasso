-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'TR060', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR060', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'A', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'A', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'A', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR060', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'TR060', 't1__c252bd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_8', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__e29ddc', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_8', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't2__03003c', 'A');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR060', 't2__61d231');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__e29ddc', 't2__61d231');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__864e96', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__03003c', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_7', 'Q');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_8', 'A');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_9', 'O');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__10', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR060';

/*
Gold Result:
('t1__c252bd', 't2__61d231')
*/

-- Prediction Query
SELECT T1.element, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR060';

/*
Prediction Result:
('t1__c252bd', 't2__61d231')
('t1__c252bd', 't2__61d231')
('t1__c252bd', 't2__61d231')
('t1__c252bd', 't2__61d231')
*/