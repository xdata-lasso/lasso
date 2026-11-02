-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__462dba', 't1__9ca05a', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__9ca05a', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__9ca05a', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__9ca05a', 'br');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__9ca05a', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t3__c2f15a', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__99dcc6', 'tti');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__9ca05a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'G', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'I', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'O', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__9ca05a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 't3__c2f15a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't3__c2f15a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__9ca05a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't3__c2f15a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__9ca05a', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__9ca05a', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT a.atom_id) FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON b.bond_id = c.bond_id WHERE b.bond_type = '#' AND a.element IN ('p', 'br');

/*
Prediction Result:
(0,)
*/