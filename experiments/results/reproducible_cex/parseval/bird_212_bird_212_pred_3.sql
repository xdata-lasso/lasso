-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't2__1296d0', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__1c4c51', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__2488f8', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't2__1296d0', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__1c4c51', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__2488f8', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__bb395d', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__bb395d', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__2488f8', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__bb395d', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__2488f8', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__bb395d', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__2488f8', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__bb395d', 'I');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__1c4c51', 'I');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__55a03a', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__2488f8', 't1__b7a793');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__bb395d', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__1c4c51', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__55a03a', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__2488f8', 't1__b7a793');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't1__bb395d', '_');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't1__1c4c51', '_');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__55a03a', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't1__2488f8', 't1__b7a793');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't2__1296d0', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't2__1296d0', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't2__1296d0', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_34', 't1__1c4c51', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_35', 't2__9c0eb1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_36', 't1__2488f8', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_37', 't2__1296d0', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_38', 't1__1c4c51', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_39', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_40', 't1__2488f8', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_41', 't2__1296d0', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_42', 't1__1c4c51', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_43', 't2__9c0eb1', 't1__f6fc61');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_44', 't1__2488f8', 't1__f6fc61');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__1296d0', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1c4c51', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__9c0eb1', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__2488f8', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_5', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__bb395d', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__55a03a', 'gu7v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('I',)
('O',)
('_',)
(None,)
*/

-- Prediction Query
SELECT atom.element FROM atom INNER JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '-' GROUP BY atom.element ORDER BY COUNT(atom.element) ASC, atom.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/