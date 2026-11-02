-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA45A', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('QAAAAA45A', 'molecule_i_1', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA45A', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAAAAA45A', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_AAAAA45A', 'molecule_i_1', 'w6kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('QAAAAAAAA', 'molecule_i_1', 'ecigce376n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__181c1f', 'molecule_i_1', '52zbuo4nrq');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__2c74ed', 'molecule_i_1', 't1__c1bea2');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't1__c1bea2');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'b');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__7f6a61', 'molecule_i_1', 't1__c1bea2');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('AAAAAA45A', 'AAAAAA45A', 't1__2c74ed');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('QAAAAA45A', 'QAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAAAAA45A', 'AAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'AAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_AAAAA45A', 'AAAAAA45A', 't2__7f6a61');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('QAAAAA45A', 'AAAAAA45A', 't2__7f6a61');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAAAAA45A', 'OAAAAA45A', 't2__7f6a61');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_AAAAA45A', '_AAAAA45A', 't2__7f6a61');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'GAAAAA45A', 't2__7f6a61');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'OAAAAA45A', 't2__7f6a61');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('QAAAAAAAA', 'QAAAAA45A', 't1__2c74ed');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__181c1f', '_AAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAAAAA45A', 'QAAAAAAAA', 't1__2c74ed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE SUBSTRING(T2.atom_id, 7, 2) = '45';

/*
Gold Result:
('t1__c1bea2', 't1__2c74ed')
('b', 'A')
('b', 'A')
('b', 'A')
('t1__c1bea2', 't2__7f6a61')
('t1__c1bea2', 't2__7f6a61')
('t1__c1bea2', 't2__7f6a61')
('t1__c1bea2', 't2__7f6a61')
('t1__c1bea2', 't2__7f6a61')
('t1__c1bea2', 't2__7f6a61')
('t1__c1bea2', 't1__2c74ed')
*/

-- Prediction Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 LEFT JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = '45';

/*
Prediction Result:
*/