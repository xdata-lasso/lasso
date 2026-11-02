-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__180bbf', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__d45005', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '02eu');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('1', 'molecule_i_1', '8c4pgu7vfe');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__180bbf', 't1__180bbf', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 'C', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'Q', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'I', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 't1__180bbf', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'atom_id_8', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'atom_id_9', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'Q', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'C', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'atom_id_10', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 't2__d45005', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'atom_id_11', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__180bbf', 'atom_id_10', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__180bbf', 'atom_id_12', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d45005', 'atom_id_13', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__180bbf', 'atom_id_8', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__180bbf', 'atom_id_14', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT COUNT(*) / COUNT(DISTINCT T1.atom_id) AS average_bonds FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'i';

/*
Prediction Result:
(5,)
*/