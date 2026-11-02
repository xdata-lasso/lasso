-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t_s_98c620', 'TR010', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'T', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'T', 't_s_bdaad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H', 'T', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR010', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('T', '9n8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
('t_s_98c620',)
*/

-- Prediction Query
SELECT atom_id FROM atom WHERE element = 'c' AND CAST(SUBSTRING(molecule_id, 3, 2) AS INTEGER) >= 10 AND CAST(SUBSTRING(molecule_id, 3, 2) AS INTEGER) <= 50;

/*
Prediction Result:
*/