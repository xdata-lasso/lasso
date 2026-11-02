-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA?C?', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_4d3812', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_5ac0a8', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_55826d', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_93b983', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('__W?_O', 'molecule_i_1', '5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AACCG', 'molecule_i_1', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA[O?', 'molecule_i_1', '4ecigce376n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('o_!Io!', 'molecule_i_1', '52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAGK/E', 'molecule_i_1', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA+!_', 'molecule_i_1', '5bbp0');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR009a', 'molecule_i_1', 'ia2yp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA?C?', 'TR009_12', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_4d3812', 'con_5ac0a8', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_55826d', 'con_93b983', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('__W?_O', 'TR009_12', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AACCG', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA[O?', 'TR009_12', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('o_!Io!', 'TR009_12', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAGK/E', 'TR009_12', 'TR009a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA+!_', 'TR009a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(bond_id) FROM connected WHERE (atom_id = 'TR009_12' OR atom_id2 = 'TR009_12') AND bond_id LIKE 'TR009_%';

/*
Prediction Result:
(7,)
*/