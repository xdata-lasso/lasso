-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__cedf4f', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__cedf4f', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'A', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'A', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'H', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', '!', 't1__f287d2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'P', 't1__f287d2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'B', 't1__f287d2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('`', 'C', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'D', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__cedf4f', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__9d75e8', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('P', 't2__e8c05a');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', 't2__e8c05a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('t1__cedf4f',)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'c' AND T1.label = '-';

/*
Prediction Result:
(2,)
*/