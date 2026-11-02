-- Schema DDL
CREATE TABLE EVENT (EVENT_ID TEXT PRIMARY KEY, EVENT_NAME TEXT);

CREATE TABLE BUDGET (BUDGET_ID TEXT PRIMARY KEY, CATEGORY TEXT, AMOUNT INTEGER, LINK_TO_EVENT TEXT, FOREIGN KEY (LINK_TO_EVENT) REFERENCES EVENT (EVENT_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO event (event_id, event_name) VALUES ('April Speaker', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.amount), T2.category FROM EVENT AS T1 INNER JOIN BUDGET AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'April Speaker' ORDER BY T2.amount, T1.event_id NULLS LAST, T2.budget_id NULLS LAST;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT category, SUM(CAST(amount AS REAL)) AS total_budgeted FROM BUDGET JOIN EVENT ON BUDGET.link_to_event = EVENT.event_id WHERE EVENT.event_name = 'April Speaker' GROUP BY category ORDER BY total_budgeted ASC, category NULLS LAST;

/*
Prediction Result:
*/