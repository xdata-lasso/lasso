-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__9d2ee3', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'l');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'lbn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'siie');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'ryytoo3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '72k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'yrq13pyu78d9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'b4yp5qi');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'f9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'z0f8jegd21vy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'j4hwbd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'nd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'x5hncprjtu0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__5cb5b0', 'molecule_i_1', '79fjgq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', 'qv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 'molecule_i_1', 'i');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__c90b11', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__8670d5', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__88d290', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'molecule_i_1', 't1__de6df3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 'molecule_i_1', 't1__de6df3');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 't2__9d2ee3', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_2', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_3', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_4', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_3', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_2', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_8', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 'atom_id_8', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__9d2ee3', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_10', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_11', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_11', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('E', 'atom_id_10', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_13', 't2__88d290');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'E', 't2__88d290');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', '?', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', '@', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_14', 't2__88d290');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_15', 't2__88d290');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_16', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_17', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_18', 't2__88d290');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_19', 't2__88d290');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_20', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_21', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_22', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', '!', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_23', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_25', 't1__c90b11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9d2ee3', 'atom_id_26', 't1__c90b11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
('t1__de6df3',)
*/

-- Prediction Query
SELECT bond.bond_type FROM bond INNER JOIN atom ON bond.molecule_id = atom.molecule_id WHERE atom.element = 'cl';

/*
Prediction Result:
*/