-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__eec1ec', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't2__12b87e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__eec1ec', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't2__12b87e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__a1529e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't2__12b87e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't2__12b87e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't2__12b87e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't2__8dd84d', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't2__5de7e5', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__d2a928', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't2__12b87e', 't1__9bb5f2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't2__8dd84d', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't2__5de7e5', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__d2a928', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't2__12b87e', 't1__9bb5f2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't2__8dd84d', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't2__5de7e5', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__d2a928', 'Q');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't2__12b87e', 't1__9bb5f2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 'molecule_i_5', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't1__a1529e', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't2__8dd84d', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_34', 't1__eec1ec', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_35', 't2__045e70', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_36', 't2__12b87e', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_37', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_38', 't1__eec1ec', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_39', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_40', 't2__12b87e', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_41', 't2__8dd84d', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_42', 't1__eec1ec', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_43', 't2__045e70', 't1__f75ad2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_44', 't2__12b87e', 't1__f75ad2');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__8dd84d', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__eec1ec', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__045e70', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__12b87e', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_5', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a1529e', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__5de7e5', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__d2a928', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('E',)
('G',)
('t1__f75ad2',)
(None,)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(T1.element), T1.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/