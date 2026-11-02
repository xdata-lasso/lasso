-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__5a21a4', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__5a21a4', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', '@', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '@', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', '@', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__5a21a4', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '8', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H', 'D', 't1__f72387');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'H', 't1__f72387');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'B', 't1__f72387');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'Q', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__5a21a4', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__7ca04b', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('8', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', 't2__9031ae');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('t1__5a21a4',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Prediction Result:
('t1__5a21a4',)
('t1__5a21a4',)
('t1__5a21a4',)
*/