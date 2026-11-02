-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('EAAAAA4', 't1__fdd177', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__1847c9', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4', 'A', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAAAAA4', 'A', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA4', 't1__fdd177', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAAA', 't1__fdd177', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 't1__fdd177', 't1__a287a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_AAAAA4', 't1__fdd177', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A@A_AA4', '@', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A?AAAA4', 't1__fdd177', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_@AAAA4', 'B', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AKA!AA4', 't1__fdd177', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!@_AAA4', '`', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@BAAAA4', 'H', 'mdpos');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__fdd177', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1847c9', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__d43baf', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('`', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('t1__a287a9',)
('gu7v',)
('e4',)
('hria2ypuzhs',)
('rwbbp6luhvd',)
('tti',)
('bnp',)
('mdpos',)
*/

-- Prediction Query
SELECT element, COUNT(*) AS count FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, 7, 1) = '4' GROUP BY T1.element;

/*
Prediction Result:
('bnp', 1)
('e4', 1)
('gu7v', 1)
('hria2ypuzhs', 1)
('mdpos', 1)
('rwbbp6luhvd', 1)
('t1__a287a9', 2)
('tti', 1)
*/