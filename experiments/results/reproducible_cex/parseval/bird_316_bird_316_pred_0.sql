-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__7ce75a', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__7ce75a', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__7ce75a', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'A', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'H', 't1__3a2122');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'O', 't1__3a2122');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('F', 'C', 't1__3a2122');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'B', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('`', '"', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__7ce75a', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__a2a1a7', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 't2__44e8aa');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('"', 't2__44e8aa');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('t1__7ce75a',)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'C' AND T2.label = '-';

/*
Prediction Result:
*/