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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Maine18', 'Vermont64', 'Vermont64', 'Vermont64', 'Vermont64', 'Vermont64', 'Vermont64');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member17', 'Vermont64', 'Vermont64', 'Vermont64', 'Vermont64', 'Vermont64', 'Vermont64');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Maine63', 'Vermont64', 'Vermont64', 'Vermont64');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (64, 'Maine57', 'Vermont58', 'Member59', 'Maine60', 'Vermont61');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (25, 'Maine30', NULL, 'Member32', 'Vermont', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Maine18', 'Vermont19');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Maine21', 'Member17', 'Vermont64', 64, 64, 64, 'Vermont64');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Member20', 'Member17', 'Vermont64', 64, 64, 64, 'Vermont64');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Vermont64', 'Member20', 'Vermont19', 'Vermont64', 'Vermont64', 64, 'Vermont64');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member23', 'Vermont19', 'Vermont64', 64, 'Vermont64', 'Vermont64');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Vermont22', 'Vermont19', 'Vermont64', 64, 'Vermont64', 'Vermont64');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member62', 'Maine63', 64, 'Member65', 'Maine66', 'Vermont67', 'Member', 'Member68', 'Maine69');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Vermont19', NULL, 25, NULL, NULL, NULL, 'Vermont37', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(-50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.state = 'Maine' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.position) - CAST(SUM(CASE WHEN T1.state = 'Vermont' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.position) FROM zip_code AS T1 INNER JOIN member AS T2 ON T1.zip_code = T2.zip WHERE T2.position = 'Member';

/*
Prediction Result:
(0.0,)
*/