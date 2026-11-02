-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'C', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__485cf8', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__485cf8', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__485cf8', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__c8b697', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'B', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 'ca');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__c8b697', 't2__e5a976');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 't2__e5a976');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', 't2__e5a976');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__485cf8', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__e60738', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', 't2__61ce0c');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__61ce0c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__e5a976',)
*/

-- Prediction Query
SELECT CASE WHEN SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) > SUM(CASE WHEN T2.label = '-' THEN 1 ELSE 0 END) THEN 'Carcinogenic' ELSE 'Non-Carcinogenic' END AS Result FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'Ca';

/*
Prediction Result:
('Non-Carcinogenic',)
*/