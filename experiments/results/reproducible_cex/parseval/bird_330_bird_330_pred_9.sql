-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__7dc400', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__7dc400', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'A', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__c3a875', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__c3a875', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't3__f1fa09', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't3__f1fa09', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't2__c3a875', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't3__f1fa09', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't2__c3a875', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't3__f1fa09', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__7dc400', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__7dc400', 't2__feabf4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__7dc400', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__7dc400', 'h');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__7dc400', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__c3a875', 'tti');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t3__f1fa09', 'bnp');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__7dc400', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__7dc400', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'G', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'Q', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'G', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', '_', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'I', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', '_', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 't2__c3a875', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't3__f1fa09', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't3__f1fa09', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 't2__c3a875', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't2__c3a875', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't2__c3a875', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 't3__f1fa09', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__7dc400', 't3__4f1dbd');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't1__7dc400', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't1__7dc400', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 't1__7dc400', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.molecule_id IN (SELECT T1.molecule_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id OR T1.atom_id = T2.atom_id2 INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'h' AND T3.bond_type = '#' AND T1.molecule_id = T3.molecule_id) THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(T1.molecule_id) FROM molecule AS T1 WHERE T1.label = '+';

/*
Prediction Result:
(None,)
*/