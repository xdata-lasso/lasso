-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('25', 't2__d05b16', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('21', 't2__d05b16', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't2__d05b16', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__d05b16', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't2__d05b16', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('2', 't2__d05b16', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#', 't2__d05b16', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__602229', 'A', 'e5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('22', 'B', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('24', 'O', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s', 'C', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('0', 'D', 'gu7v');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__d05b16', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__0eaaf8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 't2__0eaaf8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', 't2__0eaaf8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('t2__d05b16',)
*/

-- Prediction Query
SELECT DISTINCT molecule.molecule_id FROM atom INNER JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE SUBSTRING(atom.atom_id, 7, 2) BETWEEN '21' AND '25' AND molecule.label = '+';

/*
Prediction Result:
('A',)
*/