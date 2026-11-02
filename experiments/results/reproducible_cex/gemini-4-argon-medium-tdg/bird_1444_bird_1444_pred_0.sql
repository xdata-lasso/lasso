-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. AVG(DISTINCT cost) vs AVG(cost): Group with (40, 40, 80) has AVG = 53.33 (> 50), whereas AVG(DISTINCT) = 60.
--    Group with (20, 60, 60) has AVG = 46.67 (<= 50), whereas AVG(DISTINCT) = 40.
--    Group with (30, 60, 60) has AVG = 50.0 (<= 50), whereas AVG(DISTINCT) = 45.
--    Group with (10, 70, 70) has AVG = 50.0 (<= 50), whereas AVG(DISTINCT) = 40.
--    Group with (25, 65, 65) has AVG = 51.67 (> 50), whereas AVG(DISTINCT) = 45 (<= 50) -> kills AVG(DISTINCT cost).
-- 2. Integer division vs Floating point division: Group with (50, 51) has AVG = 50.5 (> 50), integer avg would be 50 (<= 50).
-- 3. NULL handling in cost and expense_description:
--    Group with (80, NULL) has AVG(cost) = 80 (> 50), whereas SUM(cost)/COUNT(*) = 40 (<= 50).
--    NULL expense_description with cost 100 (> 50) should be included as a valid group in SQL.
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e1', 'KillAvgDistinct_1', 25.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e2', 'KillAvgDistinct_1', 65.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e3', 'KillAvgDistinct_1', 65.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e4', 'KillAvgDistinct_2', 75.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e5', 'KillAvgDistinct_2', 35.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e6', 'KillAvgDistinct_2', 35.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e7', 'FloatPrecision', 50.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e8', 'FloatPrecision', 51.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e9', 'NullCostHandling', 80.0);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e10', 'NullCostHandling', NULL);
INSERT INTO expense (expense_id, expense_description, cost) VALUES ('e11', NULL, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT expense_description FROM expense GROUP BY expense_description HAVING AVG(cost) > 50;

/*
Gold Result:
(None,)
('FloatPrecision',)
('KillAvgDistinct_1',)
('NullCostHandling',)
*/

-- Prediction Query
SELECT expense_description FROM expense GROUP BY expense_description HAVING SUM(cost) / COUNT(expense_id) > 50;

/*
Prediction Result:
(None,)
('FloatPrecision',)
('KillAvgDistinct_1',)
*/