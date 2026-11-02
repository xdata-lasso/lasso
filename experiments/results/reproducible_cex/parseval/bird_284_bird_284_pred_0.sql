-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__9b53c6', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__12612f', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'O', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'Q', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'O', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'O', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'O', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'O', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__9b53c6', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__9b53c6', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__9b53c6', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__9b53c6', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__9b53c6', 't1__d9cd0a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__12612f', 't1__3ced13');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__9b53c6', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__12612f', 'te');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__9b53c6', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__12612f', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'e4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__9b53c6', 't2__414b85');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__9b53c6', 't2__414b85');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'A', 't2__414b85');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'A', 't2__414b85');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('t2__414b85',)
*/

-- Prediction Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'te';

/*
Prediction Result:
*/