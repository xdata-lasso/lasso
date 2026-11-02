-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__ec288f', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__ec288f', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__ec288f', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__ec288f', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__ec288f', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__ec288f', '1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__ec288f', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__ec288f', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__ec288f', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__890d81', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__ec288f', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__ec288f', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__ec288f', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't1__ec288f', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't1__ec288f', 't2__0317c7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't1__ec288f', 't2__0317c7');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ec288f', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__890d81', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT T2.element FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(T2.element) ASC, T2.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/