-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_10', 't1__1814a5', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9d03c5', 't1__1814a5', '4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1814a5', 't2__39bfb3');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_3', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 't2__39bfb3');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_6', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 't2__39bfb3');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_8', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 't2__39bfb3');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__10', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__11', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__12', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__13', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__68e535', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__15', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.molecule_id, IIF(T2.label = '+', 'YES', 'NO') AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.atom_id = 'TR001_10';

/*
Gold Result:
('t1__1814a5', 'NO')
*/

-- Prediction Query
SELECT T2.label, CASE WHEN T2.label = '+' THEN 'Carcinogenic' ELSE 'Not Carcinogenic' END AS Carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.atom_id = 'TR001_10';

/*
Prediction Result:
('t2__39bfb3', 'Not Carcinogenic')
*/