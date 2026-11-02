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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('red', 'Mark Weber', 'low', 'animal', 'Republican social two notice.', '09143 Todd River
North Devinfort, LA 26979', 'decade');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('box', 'Jennifer Patterson', 'teacher', 'discover', 'Where outside wonder recent question.', '039 Stevenson Isle
West Lonnie, WY 05692', 'language');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('team', 'Brian Morris', 'family', 'fish', 'Forward play this fish.', '403 Cooper Ford Apt. 339
Boydburgh, NV 83047', 'control');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('general', 'Matthew Smith', 'rate', 'money', 'Attack adult treatment large memory score me.', '30232 Glenn Plaza Apt. 381
Hardyport, GA 95092', 'police');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('right', 'Tyler Campbell', 'course', 'region', 'Even material hard enter.', '7676 Taylor Shoal Apt. 668
Ryanfort, ND 70783', 'theory');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('senior', 'Gene Ward', 'respond', 'probably', 'Small technology within sing.', '96893 Joe Alley Apt. 058
Rosarioville, AR 46290', 'teach');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('condition', 'Angela Williams', 'large', 'happen', 'Floor hospital return size.', '7286 Jason Fork
Lake Devinberg, MS 96587', 'southern');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('break', 'Jeffrey Rogers', 'citizen', 'type', 'Spring both into risk certain follow camera.', '0191 Monroe Ways Apt. 025
North John, AL 75104', 'six');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('energy', 'Karen Tapia', 'late', 'on');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('feeling', 'James Ruiz', 'too', 'even');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('part', 'Leon Hamilton', 'first', 'husband');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('expert', 'Troy Olson', 'claim', 'major');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('challenge', 'Nathan Wallace', 'once', 'close');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('smile', 'Alexis Rodriguez', 'wide', 'best');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('news', 'Marvin Munoz', 'more', 'nearly');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('firm', 'Christopher Sanders', 'security', 'car');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1645, 'follow', 'Lake Taylor', 'foot', 'Wyoming', 'val_1651');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1646, 'or', 'East Adam', 'per', 'Iowa', 'val_1652');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1647, 'away', 'Travischester', 'avoid', 'val_1649', 'val_1653');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1648, 'goal', 'Wallerstad', 'American', 'val_1650', 'val_1654');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1671, 'present', 'Port Heatherfort', 'body', 'val_1675', 'val_1679');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1672, 'including', 'Denisefurt', 'throughout', 'val_1676', 'val_1680');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1673, 'create', 'Martinstad', 'government', 'val_1677', 'val_1681');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1674, 'point', 'Leeville', 'number', 'val_1678', 'val_1682');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('activity', 'side', 1655.5, 1659.5, 1663, 'star', 'red');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('cup', 'far', 1662.5, 1668.5, 1674.0, 'wrong', 'red');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('discuss', 'establish', 1669.5, 1677.5, 1685.0, 'statement', 'red');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('heart', 'trip', 1676.5, 1686.5, 1696.0, 'born', 'red');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('both', 'pull', 1683.5, 1687.5, 1691, 'over', 'right');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('ok', 'alone', 1690.5, 1696.5, 1702.0, 'other', 'right');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('population', 'effect', 1697.5, 1705.5, 1713.0, 'organization', 'right');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('water', 'exist', 1704.5, 1714.5, 1724.0, 'member', 'right');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('seven', 'Desiree', 'Montoya', 'omoore@example.net', 'raise', 'commercial', '+1-393-812-1637x61820', 1645, 'energy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('rise', 'Molly', 'Walker', 'erichardson@example.org', 'father', 'cost', '(301)700-2314x2900', 1645, 'energy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('idea', 'Cynthia', 'Adams', 'lwhite@example.org', 'against', 'television', '001-513-227-9724x572', 1645, 'energy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('young', 'Andrea', 'Perkins', 'ashleyharding@example.org', 'force', 'indeed', '+1-348-810-0184', 1645, 'energy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('forward', 'Susan', 'Kelly', 'shawkimberly@example.org', 'responsibility', 'politics', '001-357-425-4596x06339', 1671, 'challenge');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('better', 'Vincent', 'Anderson', 'cwoods@example.com', 'ready', 'reach', '001-371-902-4817', 1671, 'challenge');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('yet', 'Leonard', 'Leonard', 'edwardford@example.net', 'chance', 'necessary', '924-621-4955x11274', 1671, 'challenge');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('heavy', 'Peter', 'Rivera', 'cisnerosjesse@example.org', 'college', 'wonder', '001-772-719-7054x66927', 1671, 'challenge');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('and', 'Water, chips, cookies', 'agent', 1722.5, 'few', 'seven', 'activity');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('change', 'Water, chips, cookies', 'dream', 1676.5, 'draw', 'seven', 'activity');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('door', 'Water, chips, cookies', 'image', 1685.5, 'until', 'seven', 'activity');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('everyone', 'Water, chips, cookies', 'head', 1694.5, 'return', 'seven', 'activity');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('ability', 'Water, chips, cookies', 'pressure', 1722.5, 'two', 'forward', 'both');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('hour', 'Water, chips, cookies', 'clear', 1704.5, 'happy', 'forward', 'both');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('rest', 'Water, chips, cookies', 'fill', 1713.5, 'management', 'forward', 'both');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('while', 'Water, chips, cookies', 'cold', 1667.5, 'quality', 'forward', 'both');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('both',)
*/

-- Prediction Query
SELECT T1.budget_id FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T2.expense_description = 'Water, chips, cookies' ORDER BY T2.cost DESC, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('activity',)
*/