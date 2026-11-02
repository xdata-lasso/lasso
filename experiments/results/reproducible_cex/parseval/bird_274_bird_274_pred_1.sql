-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR001', 't_s_79644b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'TR001', 't_s_79644b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't_s_aca10e', 't_s_79644b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR001', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't_s_66d363', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't_s_66d363', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't_s_66d363', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't_s_66d363', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't_s_aca10e', '?');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'TR001', 'A');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_aca10e', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_66d363', '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR001';

/*
Gold Result:
('t_s_79644b',)
(None,)
('A',)
*/

-- Prediction Query
SELECT element FROM atom WHERE molecule_id = 'TR001';

/*
Prediction Result:
('t_s_79644b',)
('t_s_79644b',)
(None,)
('A',)
*/