-- Schema DDL
/* Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE udaxih (utlsgw INTEGER PRIMARY KEY, cbvhyj TEXT(100) NOT NULL UNIQUE, chdmio TEXT(100) NOT NULL);

CREATE TABLE hexdvx (ulfllg INTEGER PRIMARY KEY, viwvuc TEXT(100) NOT NULL, utlsgw INTEGER NOT NULL, tufrxh TEXT(50) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE rcsnba (rhvkyy INTEGER PRIMARY KEY, bhbzkm TEXT(100) NOT NULL UNIQUE, utlsgw INTEGER NOT NULL, icgswk REAL NOT NULL, gupmuo TEXT(20) NOT NULL, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE cghqta (eiehxr INTEGER PRIMARY KEY, ulfllg INTEGER NOT NULL, rhvkyy INTEGER NOT NULL, rixsns TEXT(20) NOT NULL, mlheqp REAL NOT NULL, UNIQUE (ulfllg, rhvkyy), FOREIGN KEY (ulfllg) REFERENCES hexdvx (ulfllg), FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy));

CREATE TABLE rgwuwr (cybdeu INTEGER PRIMARY KEY, rhvkyy INTEGER NOT NULL, fzvntc INTEGER, tufrxh TEXT(200) NOT NULL, mmtoqi TEXT(20) NOT NULL, gupmuo TEXT(20) NOT NULL, ravxdv TEXT(20) NOT NULL, FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy), FOREIGN KEY (fzvntc) REFERENCES hexdvx (ulfllg));

CREATE TABLE nhosiz (ryiyuk INTEGER PRIMARY KEY, djnfoa TEXT(100) NOT NULL, xxiqyf TEXT(20) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1);

CREATE TABLE ayzfwn (qdujuq INTEGER PRIMARY KEY, ryiyuk INTEGER NOT NULL, tgelyf TEXT(20) NOT NULL, ryqatk TEXT(20) NOT NULL, padlzj TEXT(20) NOT NULL DEFAULT 'STANDARD', hbhscc REAL NOT NULL DEFAULT 0, FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

CREATE TABLE kiegyk (xpcyry INTEGER PRIMARY KEY, eevprf TEXT(100) NOT NULL UNIQUE, iqtngr TEXT(50) NOT NULL);

CREATE TABLE dcmdll (yxwgwj INTEGER PRIMARY KEY, xpcyry INTEGER NOT NULL, mvuloq TEXT(100) NOT NULL, odhhck REAL NOT NULL, asrhsh INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (xpcyry) REFERENCES kiegyk (xpcyry));

CREATE TABLE tizbxo (acwubh INTEGER PRIMARY KEY, qdujuq INTEGER NOT NULL, yxwgwj INTEGER NOT NULL, cbkcqh INTEGER NOT NULL, ivpgre REAL NOT NULL, xssphz REAL, UNIQUE (qdujuq, yxwgwj), FOREIGN KEY (qdujuq) REFERENCES ayzfwn (qdujuq), FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj));

CREATE TABLE rdmcrj (pzngdd INTEGER PRIMARY KEY, yxwgwj INTEGER NOT NULL, ryiyuk INTEGER NOT NULL, vnlnno INTEGER NOT NULL, xbvuud INTEGER NOT NULL DEFAULT 0, bmxkzd TEXT(20) NOT NULL, FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj), FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
/* Tests filtering before window function vs after, and basic ordering (odhhck DESC) */
INSERT INTO kiegyk (xpcyry, eevprf, iqtngr) VALUES (1, 'CatA', 'InfoA');
INSERT INTO kiegyk (xpcyry, eevprf, iqtngr) VALUES (2, 'CatB', 'InfoB');
/* Cat 1: Highest odhhck has asrhsh = 1 (must be ignored before ranking). Second highest has asrhsh = 0 (should win). Also tests asrhsh = -1. */
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (10, 1, 'Item_Ignored_High', 500.0, 1);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (11, 1, 'Item_Ignored_Neg', 600.0, -1);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (12, 1, 'Item_Valid_Mid', 300.0, 0);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (13, 1, 'Item_Valid_Low', 100.0, 0);
/* Cat 2: Only has rows with asrhsh != 0 (Category 2 should not appear in output at all). */
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (20, 2, 'Item_Cat2_Ignored', 900.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT yxwgwj, mvuloq, xpcyry, odhhck FROM (SELECT p.yxwgwj, p.mvuloq, p.xpcyry, p.odhhck, ROW_NUMBER() OVER (PARTITION BY p.xpcyry ORDER BY p.odhhck DESC, p.yxwgwj ASC) AS rank_in_cat FROM dcmdll AS p WHERE p.asrhsh = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(12, 'Item_Valid_Mid', 1, 300.0)
*/

-- Prediction Query
SELECT yxwgwj, mvuloq, xpcyry, odhhck FROM (SELECT p.yxwgwj, p.mvuloq, p.xpcyry, p.odhhck, ROW_NUMBER() OVER (PARTITION BY p.xpcyry ORDER BY p.odhhck DESC, p.yxwgwj ASC) AS rank_in_cat FROM dcmdll AS p) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(11, 'Item_Ignored_Neg', 1, 600.0)
(20, 'Item_Cat2_Ignored', 2, 900.0)
*/