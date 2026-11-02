-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_266897', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_bbdd41', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR000', 't_s_970d13');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'TR000', 't_s_970d13');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't_s_266897', 't_s_970d13');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR000', 't_s_970d13');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'TR000', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't_s_bbdd41', 'O');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 't_s_bbdd41', 'A');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 't_s_bbdd41', 'O');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't_s_bbdd41', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.bond_type FROM bond AS T WHERE T.molecule_id = 'TR000';

/*
Gold Result:
('t_s_970d13',)
(None,)
*/

-- Prediction Query
SELECT bond_type FROM bond WHERE molecule_id = 'TR000';

/*
Prediction Result:
('t_s_970d13',)
('t_s_970d13',)
('t_s_970d13',)
(None,)
*/