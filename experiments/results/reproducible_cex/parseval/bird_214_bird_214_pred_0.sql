-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__0d3604', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__4242a8', 't1__3b897f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 't1__3b897f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 't1__3b897f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'A', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 't1__3b897f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__0d3604', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__0d3604', 't1__3b897f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__0d3604', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__0d3604', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__0d3604', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__4242a8', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__0d3604', 't1__3363e7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__4242a8', 't1__3b897f');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__0d3604', 't2__b82632');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__4242a8', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 't2__b82632');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 't2__b82632');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 't2__b82632');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__982d94', '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
('t2__b82632',)
('5k5swwqcgs',)
('9n8',)
*/

-- Prediction Query
SELECT label FROM molecule WHERE NOT molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'sn');

/*
Prediction Result:
('t2__b82632',)
('9n8',)
('t2__b82632',)
('t2__b82632',)
('4',)
*/