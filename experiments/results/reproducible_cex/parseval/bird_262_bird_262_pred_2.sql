-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__eb4dec', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__a317d9', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', 't2__b4f2e5');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('L', 't2__b4f2e5');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', NULL);

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__eb4dec', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__eb4dec', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't1__eb4dec', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'H', 't1__12b3e5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'B', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('`', '!', 't1__12b3e5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('H', 'L', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('F', 'C', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' AND T1.bond_type = '-';

/*
Gold Result:
('t1__eb4dec',)
*/

-- Prediction Query
SELECT T2.molecule_id FROM bond AS T1 JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-';

/*
Prediction Result:
('t1__eb4dec',)
('t1__eb4dec',)
('t1__eb4dec',)
*/