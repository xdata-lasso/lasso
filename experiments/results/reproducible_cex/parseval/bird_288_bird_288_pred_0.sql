-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_1', 't1__e92d6d', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__3fafdb', 't1__e92d6d', 'e4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__e92d6d', 't2__48d135');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_3', 't2__909ef9');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a53cba', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_7', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_8', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__10', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__12', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__13', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__14', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__15', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__04b810', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__17', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.atom_id = 'TR001_1';

/*
Gold Result:
('t2__48d135',)
*/

-- Prediction Query
SELECT CASE WHEN T1.label = '+' THEN 'Yes' ELSE 'No' END AS Is_Carcinogenic FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.atom_id = 'TR001_1';

/*
Prediction Result:
('No',)
*/