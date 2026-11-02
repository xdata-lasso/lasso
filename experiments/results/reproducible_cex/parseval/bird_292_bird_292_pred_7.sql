-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_60d66b', 'GA011A', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'U@011A', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'U@011A', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'C@011A', 'ato_0a6442');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', '''B011A', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'ABAAAA', 'c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('GA011A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('AA011A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('9', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES (')', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('U@011A', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('KA011A', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('9A011A', 'tti');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('CAAGAA', 'bnp');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('CA011A', 'mdpos');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('1', 'ie5');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C@011A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('''B011A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ABAAAA', '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
*/

-- Prediction Query
SELECT atom.atom_id FROM atom INNER JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE CAST(SUBSTRING(molecule.molecule_id, 3, 3) AS INTEGER) BETWEEN 10 AND 50 AND atom.element = 'c';

/*
Prediction Result:
('ato_60d66b',)
('O',)
('A',)
*/