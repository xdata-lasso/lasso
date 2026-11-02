-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't2__0ee4c0', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__5204a1', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__5204a1', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__5204a1', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__5204a1', '-');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__5204a1', '-');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__5204a1', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__5204a1', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__5204a1', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__5204a1', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't2__0ee4c0', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't2__0ee4c0', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't1__5204a1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__5204a1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't1__5204a1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't1__5204a1', 't2__720f14');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't1__5204a1', 't2__720f14');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__5204a1', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__8233f6', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__0ee4c0', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('!',)
*/

-- Prediction Query
SELECT element FROM (SELECT a.element, COUNT(*) AS element_count FROM molecule AS m JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+' GROUP BY a.element) AS element_counts ORDER BY element_counts.element_count ASC, element NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/