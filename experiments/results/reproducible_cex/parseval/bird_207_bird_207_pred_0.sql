-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__77ca9a', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__ab53bc', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__ab53bc', 'vfe4hria2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'A', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__77ca9a', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__ab53bc', 'tilbn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'A', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'G', 'ecigce376n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'A', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'G', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6038bc', 't1__77ca9a', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__2542e8', 't1__77ca9a', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__ab53bc', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__ab53bc', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__77ca9a', '02eu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__ab53bc', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__77ca9a', 't1__eefe2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__ab53bc', 'o3o9hl72klex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__ab53bc', '7zw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'G', 'dwyrq13pyu78');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__77ca9a', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ab53bc', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'puzhsrw');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'dpos');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'G', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'G', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'O', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 't1__77ca9a', 't2__66d9ab');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't1__77ca9a', 't2__c45c37');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't1__77ca9a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't1__77ca9a', '=');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'C', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'A', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_3', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'O', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_11', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'Q', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'O', 'bond_id_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'Q', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'G', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'atom_id_8', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'atom_id_16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'Q', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', '_', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'A', 'bond_id_14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'atom_id_13', 'bond_id_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I', 't3__2542e8', 'bond_id_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I', 'atom_id_19', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__2542e8', 'atom_id_20', 'bond_id_16');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_20', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_21', 'bond_id_23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
('t1__eefe2f',)
*/

-- Prediction Query
SELECT DISTINCT atom.element FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = 'double';

/*
Prediction Result:
*/