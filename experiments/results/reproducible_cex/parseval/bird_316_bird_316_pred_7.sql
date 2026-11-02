-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__65bb74', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__65bb74', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__65bb74', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__65bb74', 't1__f1ee4f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'C', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'A', 't1__f1ee4f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', '!', 't1__f1ee4f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('F', 'D', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'B', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__65bb74', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__601ecc', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 't2__ba7aac');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__ba7aac');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('t1__65bb74',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'c' AND T1.label = '-';

/*
Prediction Result:
('t1__65bb74',)
('t1__65bb74',)
('t1__65bb74',)
*/