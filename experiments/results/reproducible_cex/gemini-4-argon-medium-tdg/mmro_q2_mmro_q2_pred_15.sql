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
-- DATASET 2
INSERT INTO udaxih (utlsgw, cbvhyj, chdmio) VALUES (1, 'Engineering', 'Building A');
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (101, 'Dave', 1, 'Dev', 1);
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (102, 'Eve', 1, 'Dev', 1);
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (103, 'Frank', 1, 'Dev', 1);
INSERT INTO rcsnba (rhvkyy, bhbzkm, utlsgw, icgswk, gupmuo) VALUES (201, 'ProjA', 1, 100.0, 'ACTIVE');
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (301, 101, 201, 'Lead', 40.0);
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (302, 102, 201, 'Member', 20.0);
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (303, 103, 201, 'Member', 20.0);
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (401, 201, 101, 'Task1', 'High', 'COMPLETED', 'None');
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (402, 201, 102, 'Task2', 'High', 'OVERDUE', 'None');
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (403, 201, 102, 'Task3', 'Low', 'COMPLETED', 'None');
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (404, 201, NULL, 'Task4', 'High', 'OVERDUE', 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Gold Result:
(101, 'Dave', 'Engineering')
(103, 'Frank', 'Engineering')
*/

-- Prediction Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE' AND t.ravxdv <= '2025-12-31') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Prediction Result:
(101, 'Dave', 'Engineering')
(102, 'Eve', 'Engineering')
(103, 'Frank', 'Engineering')
*/