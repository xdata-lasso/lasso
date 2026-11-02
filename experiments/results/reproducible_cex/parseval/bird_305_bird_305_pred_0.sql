-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__eee6a7', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__d85cea', 'molecule_i_1', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', '5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__da9ac2', 'molecule_i_1', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '72k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '4ji7zwa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__c66e8c', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'p5qi2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'gd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'wb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'ph2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'q');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'x');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'cprj');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'z');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__24b3bd', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'p');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 'fa9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'e');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__806d24', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__271e9f', 'molecule_i_1', '-');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 't2__eee6a7', 't1__24b3bd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 't3__d85cea', 't1__24b3bd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_3', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_4', 't3__d85cea', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_5', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_5', 't3__d85cea', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_4', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_6', 't3__d85cea', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_6', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_7', 't3__d85cea', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_8', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__d85cea', 't3__d85cea', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_9', 't3__d85cea', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_10', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__da9ac2', 'atom_id_8', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_12', 't3__d85cea', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_13', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_14', 't3__d85cea', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 't3__c66e8c', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_16', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__da9ac2', 'atom_id_3', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__da9ac2', 't3__d85cea', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_12', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_16', 't3__d85cea', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_8', 't3__c66e8c', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_14', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__da9ac2', 'atom_id_17', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__c66e8c', 't3__d85cea', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 't2__da9ac2', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_13', 't3__d85cea', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__da9ac2', 't3__c66e8c', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_18', 't1__24b3bd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_19', 't3__d85cea', 't1__24b3bd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_20', 't3__d85cea', 't3__271e9f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_21', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_22', 't3__d85cea', 't2__806d24');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__eee6a7', 'atom_id_23', 't1__24b3bd');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_17', 't3__d85cea', 't1__24b3bd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Gold Result:
('t1__24b3bd', 't2__eee6a7', 't2__eee6a7')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('G', 'atom_id_4', 't3__d85cea')
('G', 'atom_id_6', 't3__d85cea')
('G', 't3__d85cea', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 'atom_id_10')
('t2__806d24', 't2__da9ac2', 'atom_id_8')
('t2__806d24', 'atom_id_12', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 'atom_id_13')
('t3__271e9f', 'atom_id_14', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t2__806d24', 't2__eee6a7', 'atom_id_16')
('t2__806d24', 't2__da9ac2', 'atom_id_3')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 'atom_id_12')
('t3__271e9f', 'atom_id_16', 't3__d85cea')
('t3__271e9f', 'atom_id_8', 't3__c66e8c')
('t2__806d24', 't2__eee6a7', 'atom_id_14')
('t2__806d24', 't2__da9ac2', 'atom_id_17')
('t2__806d24', 't3__c66e8c', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't2__da9ac2')
('t3__271e9f', 'atom_id_13', 't3__d85cea')
('t3__271e9f', 't2__da9ac2', 't3__c66e8c')
('t1__24b3bd', 't2__eee6a7', 'atom_id_18')
('t1__24b3bd', 'atom_id_19', 't3__d85cea')
('t3__271e9f', 'atom_id_20', 't3__d85cea')
('G', 't2__eee6a7', 'atom_id_21')
('t2__806d24', 'atom_id_22', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 'atom_id_23')
('t1__24b3bd', 'atom_id_17', 't3__d85cea')
*/

-- Prediction Query
SELECT T1.bond_id, T2.atom_id, T3.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN connected AS T3 ON T1.bond_id = T3.bond_id WHERE T1.bond_type = '-';

/*
Prediction Result:
('t1__24b3bd', 't2__eee6a7', 'atom_id_18')
('t1__24b3bd', 't2__eee6a7', 'atom_id_23')
('t1__24b3bd', 't2__eee6a7', 't2__eee6a7')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 'atom_id_18')
('t1__24b3bd', 't2__eee6a7', 'atom_id_23')
('t1__24b3bd', 't2__eee6a7', 't2__eee6a7')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('G', 'atom_id_4', 'atom_id_21')
('G', 'atom_id_4', 't3__d85cea')
('G', 'atom_id_4', 't3__d85cea')
('G', 'atom_id_4', 't3__d85cea')
('G', 'atom_id_6', 'atom_id_21')
('G', 'atom_id_6', 't3__d85cea')
('G', 'atom_id_6', 't3__d85cea')
('G', 'atom_id_6', 't3__d85cea')
('G', 't3__d85cea', 'atom_id_21')
('G', 't3__d85cea', 't3__d85cea')
('G', 't3__d85cea', 't3__d85cea')
('G', 't3__d85cea', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 'atom_id_10')
('t2__806d24', 't2__eee6a7', 'atom_id_14')
('t2__806d24', 't2__eee6a7', 'atom_id_16')
('t2__806d24', 't2__eee6a7', 'atom_id_17')
('t2__806d24', 't2__eee6a7', 'atom_id_3')
('t2__806d24', 't2__eee6a7', 'atom_id_8')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 'atom_id_10')
('t2__806d24', 't2__da9ac2', 'atom_id_14')
('t2__806d24', 't2__da9ac2', 'atom_id_16')
('t2__806d24', 't2__da9ac2', 'atom_id_17')
('t2__806d24', 't2__da9ac2', 'atom_id_3')
('t2__806d24', 't2__da9ac2', 'atom_id_8')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 'atom_id_12', 'atom_id_10')
('t2__806d24', 'atom_id_12', 'atom_id_14')
('t2__806d24', 'atom_id_12', 'atom_id_16')
('t2__806d24', 'atom_id_12', 'atom_id_17')
('t2__806d24', 'atom_id_12', 'atom_id_3')
('t2__806d24', 'atom_id_12', 'atom_id_8')
('t2__806d24', 'atom_id_12', 't3__d85cea')
('t2__806d24', 'atom_id_12', 't3__d85cea')
('t2__806d24', 'atom_id_12', 't3__d85cea')
('t2__806d24', 'atom_id_12', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 'atom_id_12')
('t3__271e9f', 't2__eee6a7', 'atom_id_13')
('t3__271e9f', 't2__eee6a7', 't2__da9ac2')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 'atom_id_14', 'atom_id_12')
('t3__271e9f', 'atom_id_14', 'atom_id_13')
('t3__271e9f', 'atom_id_14', 't2__da9ac2')
('t3__271e9f', 'atom_id_14', 't3__c66e8c')
('t3__271e9f', 'atom_id_14', 't3__c66e8c')
('t3__271e9f', 'atom_id_14', 't3__c66e8c')
('t3__271e9f', 'atom_id_14', 't3__d85cea')
('t3__271e9f', 'atom_id_14', 't3__d85cea')
('t3__271e9f', 'atom_id_14', 't3__d85cea')
('t3__271e9f', 'atom_id_14', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 'atom_id_12')
('t3__271e9f', 't2__eee6a7', 'atom_id_13')
('t3__271e9f', 't2__eee6a7', 't2__da9ac2')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 'atom_id_10')
('t2__806d24', 't2__eee6a7', 'atom_id_14')
('t2__806d24', 't2__eee6a7', 'atom_id_16')
('t2__806d24', 't2__eee6a7', 'atom_id_17')
('t2__806d24', 't2__eee6a7', 'atom_id_3')
('t2__806d24', 't2__eee6a7', 'atom_id_8')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 'atom_id_10')
('t2__806d24', 't2__da9ac2', 'atom_id_14')
('t2__806d24', 't2__da9ac2', 'atom_id_16')
('t2__806d24', 't2__da9ac2', 'atom_id_17')
('t2__806d24', 't2__da9ac2', 'atom_id_3')
('t2__806d24', 't2__da9ac2', 'atom_id_8')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 'atom_id_10')
('t2__806d24', 't2__da9ac2', 'atom_id_14')
('t2__806d24', 't2__da9ac2', 'atom_id_16')
('t2__806d24', 't2__da9ac2', 'atom_id_17')
('t2__806d24', 't2__da9ac2', 'atom_id_3')
('t2__806d24', 't2__da9ac2', 'atom_id_8')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 'atom_id_12')
('t3__271e9f', 't2__eee6a7', 'atom_id_13')
('t3__271e9f', 't2__eee6a7', 't2__da9ac2')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 'atom_id_16', 'atom_id_12')
('t3__271e9f', 'atom_id_16', 'atom_id_13')
('t3__271e9f', 'atom_id_16', 't2__da9ac2')
('t3__271e9f', 'atom_id_16', 't3__c66e8c')
('t3__271e9f', 'atom_id_16', 't3__c66e8c')
('t3__271e9f', 'atom_id_16', 't3__c66e8c')
('t3__271e9f', 'atom_id_16', 't3__d85cea')
('t3__271e9f', 'atom_id_16', 't3__d85cea')
('t3__271e9f', 'atom_id_16', 't3__d85cea')
('t3__271e9f', 'atom_id_16', 't3__d85cea')
('t3__271e9f', 'atom_id_8', 'atom_id_12')
('t3__271e9f', 'atom_id_8', 'atom_id_13')
('t3__271e9f', 'atom_id_8', 't2__da9ac2')
('t3__271e9f', 'atom_id_8', 't3__c66e8c')
('t3__271e9f', 'atom_id_8', 't3__c66e8c')
('t3__271e9f', 'atom_id_8', 't3__c66e8c')
('t3__271e9f', 'atom_id_8', 't3__d85cea')
('t3__271e9f', 'atom_id_8', 't3__d85cea')
('t3__271e9f', 'atom_id_8', 't3__d85cea')
('t3__271e9f', 'atom_id_8', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 'atom_id_10')
('t2__806d24', 't2__eee6a7', 'atom_id_14')
('t2__806d24', 't2__eee6a7', 'atom_id_16')
('t2__806d24', 't2__eee6a7', 'atom_id_17')
('t2__806d24', 't2__eee6a7', 'atom_id_3')
('t2__806d24', 't2__eee6a7', 'atom_id_8')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 'atom_id_10')
('t2__806d24', 't2__da9ac2', 'atom_id_14')
('t2__806d24', 't2__da9ac2', 'atom_id_16')
('t2__806d24', 't2__da9ac2', 'atom_id_17')
('t2__806d24', 't2__da9ac2', 'atom_id_3')
('t2__806d24', 't2__da9ac2', 'atom_id_8')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't2__da9ac2', 't3__d85cea')
('t2__806d24', 't3__c66e8c', 'atom_id_10')
('t2__806d24', 't3__c66e8c', 'atom_id_14')
('t2__806d24', 't3__c66e8c', 'atom_id_16')
('t2__806d24', 't3__c66e8c', 'atom_id_17')
('t2__806d24', 't3__c66e8c', 'atom_id_3')
('t2__806d24', 't3__c66e8c', 'atom_id_8')
('t2__806d24', 't3__c66e8c', 't3__d85cea')
('t2__806d24', 't3__c66e8c', 't3__d85cea')
('t2__806d24', 't3__c66e8c', 't3__d85cea')
('t2__806d24', 't3__c66e8c', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 'atom_id_12')
('t3__271e9f', 't2__eee6a7', 'atom_id_13')
('t3__271e9f', 't2__eee6a7', 't2__da9ac2')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__c66e8c')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 't2__eee6a7', 't3__d85cea')
('t3__271e9f', 'atom_id_13', 'atom_id_12')
('t3__271e9f', 'atom_id_13', 'atom_id_13')
('t3__271e9f', 'atom_id_13', 't2__da9ac2')
('t3__271e9f', 'atom_id_13', 't3__c66e8c')
('t3__271e9f', 'atom_id_13', 't3__c66e8c')
('t3__271e9f', 'atom_id_13', 't3__c66e8c')
('t3__271e9f', 'atom_id_13', 't3__d85cea')
('t3__271e9f', 'atom_id_13', 't3__d85cea')
('t3__271e9f', 'atom_id_13', 't3__d85cea')
('t3__271e9f', 'atom_id_13', 't3__d85cea')
('t3__271e9f', 't2__da9ac2', 'atom_id_12')
('t3__271e9f', 't2__da9ac2', 'atom_id_13')
('t3__271e9f', 't2__da9ac2', 't2__da9ac2')
('t3__271e9f', 't2__da9ac2', 't3__c66e8c')
('t3__271e9f', 't2__da9ac2', 't3__c66e8c')
('t3__271e9f', 't2__da9ac2', 't3__c66e8c')
('t3__271e9f', 't2__da9ac2', 't3__d85cea')
('t3__271e9f', 't2__da9ac2', 't3__d85cea')
('t3__271e9f', 't2__da9ac2', 't3__d85cea')
('t3__271e9f', 't2__da9ac2', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 'atom_id_18')
('t1__24b3bd', 't2__eee6a7', 'atom_id_23')
('t1__24b3bd', 't2__eee6a7', 't2__eee6a7')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 'atom_id_19', 'atom_id_18')
('t1__24b3bd', 'atom_id_19', 'atom_id_23')
('t1__24b3bd', 'atom_id_19', 't2__eee6a7')
('t1__24b3bd', 'atom_id_19', 't3__d85cea')
('t1__24b3bd', 'atom_id_19', 't3__d85cea')
('t1__24b3bd', 'atom_id_19', 't3__d85cea')
('t3__271e9f', 'atom_id_20', 'atom_id_12')
('t3__271e9f', 'atom_id_20', 'atom_id_13')
('t3__271e9f', 'atom_id_20', 't2__da9ac2')
('t3__271e9f', 'atom_id_20', 't3__c66e8c')
('t3__271e9f', 'atom_id_20', 't3__c66e8c')
('t3__271e9f', 'atom_id_20', 't3__c66e8c')
('t3__271e9f', 'atom_id_20', 't3__d85cea')
('t3__271e9f', 'atom_id_20', 't3__d85cea')
('t3__271e9f', 'atom_id_20', 't3__d85cea')
('t3__271e9f', 'atom_id_20', 't3__d85cea')
('G', 't2__eee6a7', 'atom_id_21')
('G', 't2__eee6a7', 't3__d85cea')
('G', 't2__eee6a7', 't3__d85cea')
('G', 't2__eee6a7', 't3__d85cea')
('t2__806d24', 'atom_id_22', 'atom_id_10')
('t2__806d24', 'atom_id_22', 'atom_id_14')
('t2__806d24', 'atom_id_22', 'atom_id_16')
('t2__806d24', 'atom_id_22', 'atom_id_17')
('t2__806d24', 'atom_id_22', 'atom_id_3')
('t2__806d24', 'atom_id_22', 'atom_id_8')
('t2__806d24', 'atom_id_22', 't3__d85cea')
('t2__806d24', 'atom_id_22', 't3__d85cea')
('t2__806d24', 'atom_id_22', 't3__d85cea')
('t2__806d24', 'atom_id_22', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 'atom_id_18')
('t1__24b3bd', 't2__eee6a7', 'atom_id_23')
('t1__24b3bd', 't2__eee6a7', 't2__eee6a7')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 't2__eee6a7', 't3__d85cea')
('t1__24b3bd', 'atom_id_17', 'atom_id_18')
('t1__24b3bd', 'atom_id_17', 'atom_id_23')
('t1__24b3bd', 'atom_id_17', 't2__eee6a7')
('t1__24b3bd', 'atom_id_17', 't3__d85cea')
('t1__24b3bd', 'atom_id_17', 't3__d85cea')
('t1__24b3bd', 'atom_id_17', 't3__d85cea')
*/