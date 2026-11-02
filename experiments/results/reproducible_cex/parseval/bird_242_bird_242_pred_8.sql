-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('21', 't2__8c2689', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('22', 't2__8c2689', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('25', '@', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__8c2689', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('2', 't2__8c2689', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9500ab', 'A', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('24', 'C', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('/', '_', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', ';', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'O', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'E', 'e4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__8c2689', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 't2__c15c9e');

INSERT INTO "molecule" ("molecule_id", "label") VALUES (';', 't2__c15c9e');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 't2__c15c9e');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('E', 't2__c15c9e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('t2__8c2689',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE CAST(SUBSTRING(T1.atom_id, 7, 2) AS INTEGER) BETWEEN 21 AND 25 AND T2.label = '+';

/*
Prediction Result:
*/