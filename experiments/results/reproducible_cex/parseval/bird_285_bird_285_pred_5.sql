-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__521813', 'molecule_i_1', 't1__a22346');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__a22346');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b52806', 'molecule_i_1', 't1__a22346');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'uzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'e376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__c74cf0', 'molecule_i_1', 't1__a22346');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'fqyp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '02eu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '1ryytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'y9uxj4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_10_11', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__0bd5b3', 'molecule_i_1', '3pyu78d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__ece394', 'molecule_i_1', 'x58pz0f8je');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 't1__521813', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__521813', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__b52806', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__b52806', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_5', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_5', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'G', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'atom_id_5', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'atom_id_10', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'Q', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_11', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 't1__b52806', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'atom_id_12', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 't2__c74cf0', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'A', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'atom_id_13', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'Q', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_10', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_14', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_15', 't2__0bd5b3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'atom_id_7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__c74cf0', 'atom_id_16', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__521813', 'atom_id_17', 'TR001_10_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_id = 'TR001_10_11';

/*
Gold Result:
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('uzhs',)
('dposiie5unw',)
('e376nium52',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
('t1__a22346',)
*/

-- Prediction Query
SELECT DISTINCT t3.element FROM connected AS t1 INNER JOIN atom AS t2 ON t1.atom_id = t2.atom_id INNER JOIN atom AS t3 ON t1.atom_id2 = t3.atom_id WHERE t1.bond_id = 'TR001_10_11';

/*
Prediction Result:
('t1__a22346',)
('n',)
('9000t5c4ec',)
('fqyp',)
('e376nium52',)
('02eu',)
('1ryytoo',)
('x1',)
('au2dwy',)
('y9uxj4',)
*/