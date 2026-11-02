-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', '_', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', '_', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'C', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't2__8f5dfe', 't1__287041');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't2__8f5dfe', 't1__1a3046');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't2__8f5dfe', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't2__8f5dfe', 'c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__8f5dfe', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'gu7v');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', '?', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', '?', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', '?', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', '?', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 't2__8f5dfe', 't3__1a0f7c');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 't2__8f5dfe', 't3__3651d8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't2__8f5dfe', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_31', 't2__8f5dfe', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('t2__8f5dfe',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T2.element = 'c' AND T3.bond_type = '#' AND T1.label = '-' LIMIT 2;

/*
Prediction Result:
('t2__8f5dfe',)
('t2__8f5dfe',)
*/