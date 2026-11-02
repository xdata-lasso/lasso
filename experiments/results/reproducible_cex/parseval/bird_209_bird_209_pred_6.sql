-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e6ddfe', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 'molecule_i_1', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '1ryytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'hl72klex1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'yu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', '9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'lph2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'x');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', '9fjgq8n2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'qv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', 'lyr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', '6vck6ah0f8js');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__89d6af', 'molecule_i_1', 'lq7xb7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'molecule_i_1', 'fdrz16n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 'molecule_i_1', 'ai5');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__cc878d', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__b9fbb8', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'ia2yp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c10226', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'molecule_i_1', 't1__6a4775');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'molecule_i_1', 't1__6a4775');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 't2__e6ddfe', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_2', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_3', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_4', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_2', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'A', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_7', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_8', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', '@', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_4', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_9', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'A', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_7', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('E', '@', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_11', 't2__c10226');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_12', 't2__c10226');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'E', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_13', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_14', 't2__c10226');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_15', 't2__c10226');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_16', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_17', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_18', 't2__c10226');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_19', 't2__c10226');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_20', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_21', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_22', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_23', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_24', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_25', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_27', 't1__cc878d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6ddfe', 'atom_id_28', 't1__cc878d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
('t1__6a4775',)
('ia2yp',)
('nw6klf',)
*/

-- Prediction Query
SELECT T2.bond_type FROM atom AS T1 INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id INNER JOIN bond AS T2 ON T3.bond_id = T2.bond_id WHERE T1.element = 'cl';

/*
Prediction Result:
*/