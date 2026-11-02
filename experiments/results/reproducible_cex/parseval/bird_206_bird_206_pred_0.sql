-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__236cef', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__924dd8', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'w6kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__a65a66', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 't1__107bd1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'cigce376nium');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'ytoo3o9hl7');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_8_9', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c7e064', 'molecule_i_1', '5bbp0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c6e9f8', 'molecule_i_1', 'tliqa1');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__236cef', 't1__236cef', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__236cef', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_9', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 't1__924dd8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 't1__236cef', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_12', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_10', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_14', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_16', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_17', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__236cef', 'atom_id_8', 't2__c7e064');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__236cef', 'atom_id_15', 't2__c6e9f8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_18', 't2__c7e064');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a65a66', 'atom_id_15', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__236cef', 't2__a65a66', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__236cef', 'atom_id_14', 'TR004_8_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('t1__107bd1',)
('sr',)
('w6kl',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Prediction Result:
('t1__107bd1',)
('t1__107bd1',)
('sr',)
('sr',)
('sr',)
('sr',)
('w6kl',)
('w6kl',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
('t1__107bd1',)
*/