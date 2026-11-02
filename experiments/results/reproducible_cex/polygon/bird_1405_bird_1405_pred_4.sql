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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('April Speaker47', 'April Speaker', 'April Speaker41', 'April Speaker42', 'April Speaker43', 'April Speaker44', 'April Speaker45');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('April Speaker19', 'April Speaker47', 'April Speaker47', 'April Speaker47');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('April Speaker18', 'April Speaker47', 'April Speaker47', 'April Speaker47');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('April Speaker47', 'April Speaker23');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('April Speaker37', 'April Speaker47', 'April Speaker0', 38, 39, 1, 'April Speaker40');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('April Speaker46', 'April Speaker47', 'April Speaker1', 48, 49, 0, 'April Speaker50');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('April Speaker26', 'April Speaker46', 'April Speaker23', 'April Speaker47', 'April Speaker47', 47, 'April Speaker47');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('April Speaker25', 'April Speaker46', 'April Speaker24', 'April Speaker47', 'April Speaker47', 47, 'April Speaker47');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('April Speaker28', 'April Speaker23', 'April Speaker47', 47, 'April Speaker47', 'April Speaker47');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('April Speaker27', 'April Speaker23', 'April Speaker47', 47, 'April Speaker47', 'April Speaker47');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('April Speaker23', 'April Speaker19', 20, 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('April Speaker24', 'April Speaker18', 21, 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47', 'April Speaker47');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.amount), T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'April Speaker' ORDER BY T2.amount, T1.event_id NULLS LAST, T2.budget_id NULLS LAST;

/*
Gold Result:
(1, 'April Speaker0')
*/

-- Prediction Query
SELECT T2.category, SUM(T2.amount) AS total_amount_budgeted FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'April Speaker' GROUP BY T2.category ORDER BY total_amount_budgeted ASC, T2.category NULLS LAST;

/*
Prediction Result:
('April Speaker1', 0)
('April Speaker0', 1)
*/