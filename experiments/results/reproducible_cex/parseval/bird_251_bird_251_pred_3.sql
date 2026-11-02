-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't2__5a1efa', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__f1857c', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__f1857c', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__f1857c', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__f1857c', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__f1857c', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__f1857c', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__f1857c', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__f1857c', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__f1857c', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't2__5a1efa', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't2__5a1efa', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__f1857c', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__f1857c', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't1__f1857c', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't1__f1857c', 't2__2e4532');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't1__f1857c', 't2__2e4532');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__f1857c', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__bac0c3', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__5a1efa', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' GROUP BY T1.element ORDER BY COUNT(T1.element) ASC, T1.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/