-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'ato_c2caaa', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'mol_17ad99', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'mol_17ad99', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'mol_17ad99', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'mol_17ad99', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'mol_17ad99', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'mol_17ad99', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'mol_17ad99', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'mol_17ad99', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'mol_17ad99', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'mol_17ad99', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 'mol_17ad99', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'mol_17ad99', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 'mol_17ad99', 'ato_63d2c5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_34', 'mol_17ad99', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_35', 'mol_17ad99', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_36', 'mol_17ad99', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('mol_17ad99', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('mol_4ad3bc', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_c2caaa', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT atom.element FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+' GROUP BY atom.element ORDER BY COUNT(*) ASC, atom.element NULLS LAST LIMIT 1;

/*
Prediction Result:
('G',)
*/