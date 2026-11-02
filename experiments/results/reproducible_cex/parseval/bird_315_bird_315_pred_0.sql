-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__508fac', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__508fac', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', '@', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '@', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__508fac', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'H', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'P', 't1__1ab1a6');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'I', 't1__1ab1a6');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'a', 't1__1ab1a6');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 'D', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__508fac', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__f5e37f', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('P', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 't2__3b975a');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('a', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('t1__508fac',)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Prediction Result:
('+',)
('+',)
('+',)
*/