-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__40a23c', 't1__428fa4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__2cd733', 't1__428fa4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'O', 't1__428fa4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__40a23c', 't1__428fa4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__5b04be', 't1__40a23c', '4h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAIAAA4', 't1__40a23c', 'uzhsrwbbp6lu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4', '@', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?AAAAA4', 't1__40a23c', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@@AAAA4', 'P', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_AAAAA4', 't1__40a23c', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('BDACAA4', 'H', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C_AAAA4', 'I', 'gce376nium52');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__40a23c', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__2cd733', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__0133ba', 'ia2yp');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('P', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('uzhsrwbbp6lu',)
('hvdlttilbnpr',)
('dpos',)
('ie5',)
('nw6klf',)
('a9000t5c4eci',)
('gce376nium52',)
*/

-- Prediction Query
SELECT element, COUNT(*) FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND SUBSTRING(atom.atom_id, 7, 1) = '4' GROUP BY element;

/*
Prediction Result:
('a9000t5c4eci', 1)
('dpos', 1)
('gce376nium52', 1)
('hvdlttilbnpr', 1)
('ie5', 1)
('nw6klf', 1)
('uzhsrwbbp6lu', 1)
*/