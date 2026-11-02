-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_d25507', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't_s_d25507', 't_s_aba151');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 't_s_d25507', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('E', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('`', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('a', 't_s_d25507', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 't_s_d25507', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=';

/*
Gold Result:
('t_s_d25507',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM bond AS T1 WHERE T1.bond_type = 'double';

/*
Prediction Result:
*/