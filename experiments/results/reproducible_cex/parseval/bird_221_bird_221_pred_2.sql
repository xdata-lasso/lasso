-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_68e5c9', '4h');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bon_798013', 'molecule_i_1', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_6', 'TR001', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t_s_4b4fd0', 'TR001', 'a2y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T.bond_id, 1, 7) AS atom_id1, T.molecule_id || SUBSTRING(T.bond_id, 8, 2) AS atom_id2 FROM bond AS T WHERE T.molecule_id = 'TR001' AND T.bond_id = 'TR001_2_6';

/*
Gold Result:
('TR001_2', 'TR001_6')
*/

-- Prediction Query
SELECT T2.atom_id, T2.atom_id2 FROM connected AS T2 INNER JOIN bond AS T1 ON T2.bond_id = T1.bond_id WHERE T1.molecule_id = 'TR001' AND T1.bond_id = 'TR001_2_6';

/*
Prediction Result:
*/