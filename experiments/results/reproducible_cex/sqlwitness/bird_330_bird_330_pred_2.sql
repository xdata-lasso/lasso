-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', '+'), ('+', '+'), ('#', '#'), ('default1', 'default2'), ('h', NULL), ('unique_5', '+'), ('unique_6', 'h'), ('unique_7', NULL), ('unique_8', '#'), ('unique_9', '+'), ('unique_10', 'default2'), ('unique_11', '+'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', '#'), ('unique_15', NULL), ('unique_16', '#'), ('unique_17', 'default2'), ('unique_18', 'default1'), ('unique_19', 'h'), ('unique_20', 'h'), ('unique_21', 'default1'), ('unique_22', 'h'), ('unique_23', '+'), ('unique_24', 'default2'), ('unique_25', 'default1'), ('unique_26', 'h'), ('unique_27', '#'), ('unique_28', 'default1'), ('unique_29', '#'), ('unique_30', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('#', 'unique_7', 'default2'), ('+', 'unique_20', '+'), ('default1', 'h', 'h'), ('default2', 'unique_9', '#'), ('h', 'unique_16', 'default1'), ('unique_5', 'default1', '#'), ('unique_6', 'unique_11', 'h'), ('unique_7', 'unique_6', NULL), ('unique_8', 'unique_29', '#'), ('unique_9', 'unique_5', 'default1'), ('unique_10', 'default2', '#'), ('unique_11', 'default2', 'default2'), ('unique_12', 'unique_13', 'default1'), ('unique_13', 'unique_22', '+'), ('unique_14', 'unique_25', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('h', 'unique_6', 'default2'), ('default2', 'unique_15', '#'), ('#', 'unique_28', '#'), ('default1', 'unique_19', '#'), ('+', '#', '+'), ('unique_5', 'h', '#'), ('unique_6', 'unique_8', NULL), ('unique_7', 'unique_21', '+'), ('unique_8', 'unique_24', 'default1'), ('unique_9', 'unique_21', NULL), ('unique_10', '+', 'h'), ('unique_11', 'unique_21', 'h'), ('unique_12', NULL, 'default1'), ('unique_13', 'default2', 'default2'), ('unique_14', 'unique_25', '+'), ('unique_15', 'unique_10', '+'), ('unique_16', 'unique_7', NULL), ('unique_17', 'unique_5', 'h'), ('unique_18', NULL, 'h'), ('unique_19', 'unique_27', 'h'), ('unique_20', 'unique_20', NULL), ('unique_21', 'unique_12', NULL), ('unique_22', 'unique_22', '+'), ('unique_23', 'unique_11', 'h'), ('unique_24', 'unique_22', 'default1'), ('unique_25', 'unique_11', '#'), ('unique_26', 'unique_10', '+'), ('unique_27', NULL, NULL), ('unique_28', 'unique_17', 'default2'), ('unique_29', 'unique_29', '+'), ('unique_30', 'unique_12', 'default1'), ('unique_31', 'unique_26', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_31', 'unique_21', '+'), ('unique_17', 'unique_31', 'default2'), ('unique_21', '#', 'unique_11'), ('unique_10', 'unique_19', 'unique_8'), ('unique_12', 'unique_6', 'default2'), ('unique_29', 'unique_26', 'unique_9'), ('default2', '+', 'unique_9'), ('unique_20', 'unique_11', 'unique_5'), ('default2', 'unique_27', 'unique_11'), ('unique_5', 'unique_6', 'h'), ('unique_21', 'unique_25', 'unique_13'), ('#', 'unique_20', 'unique_12'), ('unique_24', 'unique_14', '#'), ('unique_15', '+', 'unique_13'), ('unique_10', 'unique_5', 'default1'), ('+', 'unique_11', 'unique_6'), ('unique_14', 'default2', 'unique_6'), ('unique_7', 'unique_9', 'default2'), ('unique_26', 'unique_9', 'h'), ('unique_6', 'unique_18', 'unique_5'), ('unique_5', 'unique_28', 'unique_6'), ('unique_15', '#', 'unique_9'), ('unique_25', 'unique_8', 'unique_10'), ('unique_7', '+', 'unique_8'), ('unique_29', 'unique_16', 'unique_9'), ('unique_6', 'default2', 'unique_14'), ('unique_21', 'unique_24', 'unique_7'), ('unique_21', 'unique_30', NULL), ('default1', 'h', 'unique_12'), ('unique_14', 'unique_28', 'unique_14'), ('unique_9', 'unique_22', 'unique_10'), ('unique_12', 'unique_22', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "molecule"."label" = '+' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(DISTINCT "molecule"."molecule_id") FROM "molecule" INNER JOIN "atom" ON "molecule"."molecule_id" = "atom"."molecule_id" INNER JOIN "connected" ON "atom"."atom_id" = "connected"."atom_id" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" WHERE "atom"."element" = 'h' AND "bond"."bond_type" = '#';

/*
Prediction Result:
(100.0,)
*/