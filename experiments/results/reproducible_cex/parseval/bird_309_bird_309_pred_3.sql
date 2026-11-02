-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b3cc63', 'TR346', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR346', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR346', 'gce376nium52');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR346', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__2eab53', 'qyp5s5bbp0');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__aec83d', '2eutliqa11r');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ea5089', 'ytoo3o9');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'TR346', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'TR346', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'TR346', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'A', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'A', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'A', 'hria2ypuzhs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'A', 'hria2ypuzhs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'A', 'hria2ypuzhs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 'A', 'rwbbp6luhvd');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'A', 'rwbbp6luhvd');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'A', 'rwbbp6luhvd');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 'A', 'tti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 'A', 'tti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 'A', 'tti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 'TR346', 'bnp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 'TR346', 'bnp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 'TR346', 'bnp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 'TR346', 'ie5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 'TR346', 'ie5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 'TR346', 'ie5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 'TR346', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 'TR346', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 'TR346', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 'TR346', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 'TR346', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 'TR346', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't1__2eab53', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't1__2eab53', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't1__2eab53', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_31', 'TR346', 'l7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_32', 'TR346', 'l7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_33', 'TR346', 'l7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('G', 1)
('G', 1)
('G', 1)
('G', 1)
('G', 1)
('G', 1)
('O', 1)
('O', 1)
('O', 1)
('O', 1)
('O', 1)
('O', 1)
('t1__b3cc63', 1)
('t1__b3cc63', 1)
('t1__b3cc63', 1)
('t1__b3cc63', 1)
('t1__b3cc63', 1)
('t1__b3cc63', 1)
*/

-- Prediction Query
SELECT atom.atom_id, COUNT(DISTINCT bond.bond_type) AS bond_count FROM bond INNER JOIN atom ON bond.molecule_id = atom.molecule_id WHERE bond.molecule_id = 'TR346' GROUP BY atom.atom_id;

/*
Prediction Result:
('G', 6)
('O', 6)
('t1__b3cc63', 6)
*/