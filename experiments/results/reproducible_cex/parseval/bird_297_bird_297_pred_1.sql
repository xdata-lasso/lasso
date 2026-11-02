-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__4ab80c', 't1__182ed9', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__182ed9', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__182ed9', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__182ed9', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__182ed9', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('/', '@', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', '`', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'D', 't1__23ef6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'B', 't1__23ef6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'E', 't1__23ef6c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__182ed9', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__ad8034', 'pgu7vfe4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', 't2__27102b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('`', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__27102b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('E', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('t1__4ab80c',)
('O',)
('A',)
('G',)
('Q',)
*/

-- Prediction Query
SELECT a.atom_id FROM atom AS a JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE a.element = 'c' AND m.label = '-' LIMIT 1;

/*
Prediction Result:
('t1__4ab80c',)
*/