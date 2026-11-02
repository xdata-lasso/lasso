-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__526687', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__526687', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'A', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'A', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'A', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__526687', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'B', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'C', 't1__c80011');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('K', 'D', 't1__c80011');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('J', 'E', 't1__c80011');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'F', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__526687', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__2cb69e', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', 't2__3b7d57');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('E', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('F', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('t1__526687',)
*/

-- Prediction Query
SELECT molecule.molecule_id FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE atom.element = 'cl' AND molecule.label = '+';

/*
Prediction Result:
('t1__526687',)
('t1__526687',)
('t1__526687',)
*/