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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Danielle Taylor', 'early', 'agreement', 'Information last everything thank serve civil institution.', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'benefit');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Patrick Gardner', 'mouth', 'option', 'Choice whatever from behavior benefit.', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 'someone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Amanda Davis', 'play', 'decide', 'Page southern role movie win her.', '76724 John Points Suite 969
Coxberg, NY 65187', 'anyone');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('traditional', 'Rebecca Henderson', 'activity', 'building');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('break', 'James Ferrell', 'response', 'rest');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('claim', 'Tricia Valencia', 'set', 'value');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'not', 'Danielchester', 'movement', 'South Dakota', 'Rhode Island');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1002, 'social', 'South Aaron', 'while', 'Maryland', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1003, 'example', 'Teresaburgh', 'born', 'North Carolina', 'Georgia');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('hour', 'Parking', 1004.5, 1007.5, 1010, 'notice', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('sound', 'Parking', 1011.5, 1016.5, 1021.0, 'start', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('color', 'Parking', 1018.5, 1025.5, 1032.0, 'win', 'purpose');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('nice', 'Carol', 'Cox', 'brianhumphrey@example.org', 'company', 'turn', '383.546.5787', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('why', 'Tracy', 'Galloway', 'dennislisa@example.net', 'evidence', 'policy', '215.309.8393', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'Daniel', 'Roman', 'davidalvarez@example.net', 'news', 'land', '001-403-910-5183x473', 1001, 'traditional');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('eight', 'Couple best issue interest level rock.', 'wind', 1020.5, 'system', 'nice', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('still', 'Art rock song body.', 'bag', 1022.5, 'training', 'nice', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('material', 'Couple large instead everything economic.', 'level', 1024.5, 'total', 'nice', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('oil', 'Structure why unit support coach magazine degree.', 'clear', 1016.5, 'director', 'nice', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('billion', 'Total clearly able hospital unit size.', 'customer', 1025.5, 'article', 'nice', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('apply', 'Institution whatever yet new responsibility.', 'fine', 1034.5, 'particularly', 'nice', 'hour');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Danielle Taylor',)
('Danielle Taylor',)
('Danielle Taylor',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' GROUP BY T1.event_id HAVING SUM(T3.cost) < (SELECT AVG(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking');

/*
Prediction Result:
*/