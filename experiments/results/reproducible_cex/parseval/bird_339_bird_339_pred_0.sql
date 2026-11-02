-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__86f4a6', 't1__5f8185', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__acb027', 't1__5f8185', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'O', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', '@', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'D', 't1__31a44b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H', 'B', 't1__31a44b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'F', 't1__31a44b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('J', '`', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__5f8185', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__55e9cb', 'u7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 't2__ac5dc3');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__ac5dc3');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('F', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('`', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'o' AND T2.label = '+';

/*
Gold Result:
('t1__86f4a6',)
('t1__acb027',)
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'O';

/*
Prediction Result:
*/