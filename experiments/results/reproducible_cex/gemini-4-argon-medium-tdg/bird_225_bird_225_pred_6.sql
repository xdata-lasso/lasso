-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests DISTINCT, ORDER BY ASC/DESC, LIMIT 5 (more than 5 distinct matching molecules), and filtering on bond_type = '='
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR007', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR005', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR003', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR002', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR004', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', '-');
-- Insert in non-alphabetical order to catch missing ORDER BY or wrong ORDER BY direction
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B01', 'TR007', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B02', 'TR002', '=');
-- Duplicate molecule_id with '=' to catch missing DISTINCT (also affects LIMIT count)
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B03', 'TR002', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B04', 'TR005', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B05', 'TR001', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B06', 'TR006', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B07', 'TR003', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B08', 'TR004', '=');
-- Non-matching bond_type for TR000 (which would sort first if WHERE filter is missing or wrong)
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B09', 'TR000', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B10', 'TR000', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B11', 'TR000', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('TR001',)
('TR002',)
('TR003',)
('TR004',)
('TR005',)
*/

-- Prediction Query
SELECT molecule.label FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = ' = ' ORDER BY molecule.label, bond.bond_id NULLS LAST, molecule.molecule_id NULLS LAST LIMIT 5;

/*
Prediction Result:
*/