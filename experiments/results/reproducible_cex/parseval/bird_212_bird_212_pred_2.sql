-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't2__376c15', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__dab133', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't2__376c15', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__dab133', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't2__376c15', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__dab133', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__dab133', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__dab133', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't2__d23ae7', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't2__376c15', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't2__27e735', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't2__30f7ee', 't1__afd28c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't2__d23ae7', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't2__376c15', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't2__27e735', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't2__30f7ee', 't1__afd28c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't2__d23ae7', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't2__376c15', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't2__27e735', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't2__30f7ee', 't1__afd28c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't2__376c15', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_34', 't1__dab133', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_35', 't2__30f7ee', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_36', 't2__30f7ee', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_37', 't2__d23ae7', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_38', 't2__376c15', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_39', 't1__058e7c', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_40', 't1__dab133', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_41', 't2__d23ae7', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_42', 't2__376c15', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_43', 't1__058e7c', 't1__6bcb86');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_44', 't1__dab133', 't1__6bcb86');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__d23ae7', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__376c15', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__058e7c', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__dab133', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_5', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__27e735', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__30f7ee', 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('G',)
('O',)
('t1__6bcb86',)
(None,)
*/

-- Prediction Query
SELECT a.element FROM atom AS a INNER JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE m.label = '-' GROUP BY a.element ORDER BY COUNT(a.element) ASC, a.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/