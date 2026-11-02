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
INSERT INTO udaxih (utlsgw, cbvhyj, chdmio) VALUES (2, 'default1', 'default1'), (0, 'Engineering', 'default2'), (1, 'default2', 'ACTIVE'), (3, 'OVERDUE', 'default2'), (4, 'ACTIVE', 'Engineering'), (5, 'unique_5', 'default2'), (6, 'unique_6', 'Engineering'), (7, 'unique_7', 'ACTIVE'), (8, 'unique_8', 'default2'), (9, 'unique_9', 'ACTIVE'), (10, 'unique_10', 'ACTIVE'), (11, 'unique_11', 'OVERDUE'), (12, 'unique_12', 'default1');
INSERT INTO rcsnba (rhvkyy, utlsgw, bhbzkm, icgswk, gupmuo) VALUES (0, 10, 'default2', 1.0, 'default1'), (2, 3, 'ACTIVE', 1.0, 'default1'), (1, 2, 'Engineering', 1.0, 'default2'), (3, 1, 'OVERDUE', 1.0, 'default2'), (4, 0, 'default1', 2.0, 'default2'), (5, 6, 'unique_5', 2.0, 'ACTIVE'), (6, 9, 'unique_6', 1.0, 'ACTIVE'), (7, 8, 'unique_7', 1.0, 'Engineering'), (8, 10, 'unique_8', 2.0, 'ACTIVE');
INSERT INTO hexdvx (ulfllg, utlsgw, viwvuc, tufrxh, fomiuw) VALUES (1, 10, 'default2', 'Engineering', 1), (0, 9, 'ACTIVE', 'OVERDUE', 2), (2, 0, 'Engineering', 'default1', 0), (3, 8, 'default1', 'ACTIVE', 1), (4, 8, 'ACTIVE', 'ACTIVE', 1), (5, 0, 'default1', 'default2', 0), (6, 0, 'OVERDUE', 'Engineering', 1), (7, 4, 'Engineering', 'default2', 1), (8, 12, 'OVERDUE', 'default2', 2);
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (0, 2, 5, 'default2', 'default2', 'default2', 'Engineering'), (2, 7, 1, 'Engineering', 'default1', 'default2', 'default1'), (1, 0, 8, 'Engineering', 'ACTIVE', 'ACTIVE', 'ACTIVE'), (3, 0, 4, 'Engineering', 'OVERDUE', 'ACTIVE', 'ACTIVE'), (4, 7, 1, 'ACTIVE', 'OVERDUE', 'ACTIVE', 'default1');
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (0, 0, 1, 'ACTIVE', 1.0), (2, 1, 2, 'ACTIVE', 2.0), (1, 2, 1, 'ACTIVE', 1.0), (3, 0, 0, 'default1', 2.0), (4, 1, 1, 'Engineering', 1.0), (5, 2, 0, 'default1', 1.0), (6, 0, 2, 'OVERDUE', 0.0), (7, 2, 2, 'Engineering', 1.0), (8, 1, 0, 'default1', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Gold Result:
*/

-- Prediction Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND (NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') OR EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE'));

/*
Prediction Result:
(6, 'OVERDUE', 'Engineering')
*/