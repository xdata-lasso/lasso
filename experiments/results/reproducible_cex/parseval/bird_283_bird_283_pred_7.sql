-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__1ed2e4', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__1ed2e4', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__51ecbd', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__1ed2e4', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__1ed2e4', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__1ed2e4', 't1__504de9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__1ed2e4', 'ca');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1ed2e4', 't2__3baf7a');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_3', 't2__180fc6');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__51ecbd', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_7', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_8', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 't2__3baf7a');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__10', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__11', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__12', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__13', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__14', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__2b56de', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
('t2__3baf7a',)
('t2__3baf7a',)
('5k5swwqcgs',)
('mol_f39f10',)
('mol_f39f10',)
('mol_f39f10',)
('t2__3baf7a',)
('t2__3baf7a',)
('t2__3baf7a',)
*/

-- Prediction Query
SELECT DISTINCT m.label FROM atom AS a JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE a.element = 'ca';

/*
Prediction Result:
('t2__3baf7a',)
('5k5swwqcgs',)
('mol_f39f10',)
*/