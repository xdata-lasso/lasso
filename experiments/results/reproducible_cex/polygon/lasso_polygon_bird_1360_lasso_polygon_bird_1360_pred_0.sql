-- Schema DDL
CREATE TABLE event (event_id TEXT PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE attendance (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE budget (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE expense (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE income (income_id TEXT PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE member (member_id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Parking17', 'Parking35', 'Parking35', 'Parking35', 'Parking35', 'Parking35', 'Parking35');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Parking35', 'November Speaker', 'November Speaker36', 'Parking37', 'November Speaker38', 'Parking39', 'November Speaker40');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Parking19', 'Parking35', 'Parking35', 'Parking35');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('November Speaker18', 'Parking35', 'Parking35', 'Parking35');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'Parking35', 'Parking35', 'Parking35', 'Parking35', 'Parking35');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, 'Parking35', 'Parking35', 'Parking35', 'Parking35', 'Parking35');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('November Speaker56', 'Parking35', 'Parking', 57, 58, 7, 'Parking59');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('November Speaker30', 'Parking35', NULL, 32, 33, -1, 'November Speaker34');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Parking35', NULL, 'November Speaker22', 'Parking35', 'Parking35', 35, 'Parking35');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Parking25', 'November Speaker22', 'Parking35', 35, 'Parking35', 'Parking35');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('November Speaker24', 'November Speaker22', 'Parking35', 35, 'Parking35', 'Parking35');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('November Speaker22', 'November Speaker18', 20, 'Parking35', 'Parking35', 'Parking35', 'Parking35', 'Parking35', 'Parking35');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.category = 'Parking' THEN T1.amount ELSE 0 END) AS REAL) * 100 / SUM(T1.amount) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'November Speaker';

/*
Gold Result:
(116.66666666666667,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN category = 'Parking' THEN amount ELSE 0 END) AS REAL) / CAST(SUM(amount) AS REAL)) * 100 AS percentage FROM budget JOIN event ON budget.link_to_event = event.event_id WHERE event_name = 'November Speaker';

/*
Prediction Result:
(116.66666666666667,)
*/