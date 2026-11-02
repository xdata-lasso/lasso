-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__68fa1a', 'molecule_i_1', 't1__581727');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__581727');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 't1__581727');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'puzhsrw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__0d750e', 'molecule_i_1', 't1__581727');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'lbn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'e376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '4nrq');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR005_16_26', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__54412e', 'molecule_i_1', '5c4ec');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__68fa1a', 't1__68fa1a', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__68fa1a', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__68fa1a', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'A', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'C', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 't1__68fa1a', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'atom_id_6', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'A', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'atom_id_7', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'atom_id_8', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__68fa1a', 'atom_id_7', 't2__54412e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'atom_id_9', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0d750e', 'atom_id_10', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__68fa1a', 'G', 'TR005_16_26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26';

/*
Gold Result:
('t1__581727',)
('t1__581727',)
('t1__581727',)
('puzhsrw',)
('puzhsrw',)
('puzhsrw',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
('t1__581727',)
*/

-- Prediction Query
SELECT DISTINCT t1.element FROM atom AS t1 INNER JOIN connected AS t2 ON t1.atom_id = t2.atom_id WHERE t2.bond_id = 'TR000_1_2' UNION SELECT DISTINCT t1.element FROM atom AS t1 INNER JOIN connected AS t2 ON t1.atom_id = t2.atom_id2 WHERE t2.bond_id = 'TR000_1_2';

/*
Prediction Result:
*/