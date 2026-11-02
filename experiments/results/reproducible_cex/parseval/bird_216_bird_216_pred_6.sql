-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__499016', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__1943fc', 'molecule_i_1', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__cf5ddf', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__06fde5', 'molecule_i_1', 'lbn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__ab03cb', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__9a0276', 'molecule_i_1', 'mdpos');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'w6kl');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__37cb5d', 'molecule_i_1', 'um5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__499016', 't1__1943fc', 't1__ab03cb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cf5ddf', 't1__06fde5', 't1__9a0276');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1943fc', 't1__1943fc', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1943fc', 't1__cf5ddf', 'B');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cf5ddf', 't1__cf5ddf', 't1__ab03cb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t1__499016', 't1__1943fc')
('t1__1943fc', 't1__1943fc')
('t1__1943fc', 't1__cf5ddf')
('t1__cf5ddf', 't1__cf5ddf')
*/

-- Prediction Query
SELECT T1.atom_id, T1.atom_id2 FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T2.bond_type = '#' LIMIT 2;

/*
Prediction Result:
('t1__499016', 't1__1943fc')
('t1__1943fc', 't1__1943fc')
*/