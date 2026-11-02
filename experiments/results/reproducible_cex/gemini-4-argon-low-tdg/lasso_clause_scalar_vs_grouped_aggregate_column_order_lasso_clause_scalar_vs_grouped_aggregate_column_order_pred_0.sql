-- Schema DDL
CREATE TABLE EVENT (EVENT_ID TEXT PRIMARY KEY, EVENT_NAME TEXT);

CREATE TABLE BUDGET (BUDGET_ID TEXT PRIMARY KEY, CATEGORY TEXT, AMOUNT INTEGER, LINK_TO_EVENT TEXT, FOREIGN KEY (LINK_TO_EVENT) REFERENCES EVENT (EVENT_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO EVENT (EVENT_ID, EVENT_NAME) VALUES ('E1', 'April Speaker');
INSERT INTO EVENT (EVENT_ID, EVENT_NAME) VALUES ('E2', 'May Speaker');
INSERT INTO BUDGET (BUDGET_ID, CATEGORY, AMOUNT, LINK_TO_EVENT) VALUES ('B1', 'Food', 100, 'E1');
INSERT INTO BUDGET (BUDGET_ID, CATEGORY, AMOUNT, LINK_TO_EVENT) VALUES ('B2', 'Drinks', 100, 'E1');
INSERT INTO BUDGET (BUDGET_ID, CATEGORY, AMOUNT, LINK_TO_EVENT) VALUES ('B3', 'Food', 500, 'E2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.amount), T2.category FROM EVENT AS T1 INNER JOIN BUDGET AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'April Speaker' ORDER BY T2.amount, T1.event_id NULLS LAST, T2.budget_id NULLS LAST;

/*
Gold Result:
(200, 'Food')
*/

-- Prediction Query
SELECT category, SUM(CAST(amount AS REAL)) AS total_budgeted FROM BUDGET JOIN EVENT ON BUDGET.link_to_event = EVENT.event_id WHERE EVENT.event_name = 'April Speaker' GROUP BY category ORDER BY total_budgeted ASC, category NULLS LAST;

/*
Prediction Result:
('Drinks', 100.0)
('Food', 100.0)
*/