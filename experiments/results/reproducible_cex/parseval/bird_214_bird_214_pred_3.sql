-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'A', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__4a3d90', 't1__f21acc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 't1__f21acc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 't1__f21acc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'A', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 't1__f21acc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__84c8b5', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__84c8b5', 't1__f21acc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__84c8b5', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', '_', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__4a3d90', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', '_', 't1__1baf7b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__4a3d90', 't1__f21acc');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 't2__8c3029');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__4a3d90', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 't2__8c3029');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 't2__8c3029');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 't2__8c3029');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__84c8b5', 't2__8c3029');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 't2__8c3029');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__be81ad', '9n8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
('t2__8c3029',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Prediction Result:
('t2__8c3029',)
('5k5swwqcgs',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('t2__8c3029',)
('5k5swwqcgs',)
*/