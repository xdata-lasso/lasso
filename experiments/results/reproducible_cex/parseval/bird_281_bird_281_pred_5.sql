-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('EAAAAA4', 't1__79431a', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__2518d8', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAAAAA4', 'A', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA4', 't1__79431a', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__79431a', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAAA', 't1__79431a', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 't1__79431a', 't1__cdcd00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4', 't1__79431a', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A@AGAA4', '@', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@_AGAA4', '!', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?AAAAA4', 't1__79431a', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B@AAAA4', 'B', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+AAAAA4', 't1__79431a', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B@aAAA4', 'C', 'mdpos');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__79431a', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__2518d8', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__d8e2e7', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('t1__cdcd00',)
('gu7v',)
('e4',)
('hria2ypuzhs',)
('rwbbp6luhvd',)
('tti',)
('bnp',)
('mdpos',)
*/

-- Prediction Query
SELECT atom.element, COUNT(*) AS count FROM atom INNER JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND SUBSTRING(atom.atom_id, 7, 1) = '4' GROUP BY atom.element;

/*
Prediction Result:
('bnp', 1)
('e4', 1)
('gu7v', 1)
('hria2ypuzhs', 1)
('mdpos', 1)
('rwbbp6luhvd', 1)
('t1__cdcd00', 2)
('tti', 1)
*/