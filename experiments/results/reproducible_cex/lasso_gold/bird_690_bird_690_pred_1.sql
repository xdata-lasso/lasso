-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2067, 2071, '1989-01-06', 'Emmett', '1993-05-10', 'http://www.russell-hayes.biz/', '2832 Robles Vista
Susanberg, ME 89274', 'receive', 2075, 2079, 2083, 2087, 2091, 'http://benjamin-jackson.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2069, 2076.0, '1989-01-07', 'Emmett', '1993-05-11', 'https://price.net/', '88210 Ashley Lock Apt. 435
South Rebecca, PR 67682', 'follow', 2094.0, 2100.0, 2106.0, 2112.0, 2118.0, 'http://www.singh.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2070, 2081.0, '1989-01-08', 'Emmett', '1993-05-12', 'http://www.richards.net/', '94312 Melissa Plaza
Newmanland, LA 88540', 'rule', 2113.0, 2121.0, 2129.0, 2137.0, 2145.0, 'https://griffin-hampton.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2099, 2086.0, '1989-01-09', 'Emmett', '1993-05-13', 'http://turner.info/', '97552 Craig River
East Louismouth, MA 81286', 'pattern', 2132.0, 2142.0, 2152.0, 2162.0, 2172.0, 'http://www.obrien.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2068, 2103, '1972-02-18', 'Emmett', '1976-06-22', 'http://shannon.com/', '750 Kathleen Fort
West Miketon, TN 27603', 'recent', 2107, 2111, 2115, 2119, 2123, 'https://www.leonard-mendoza.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2100, 2108.0, '1972-02-19', 'Emmett', '1976-06-23', 'https://vance.com/', '7700 Garcia Pike Suite 498
South Desiree, MN 77529', 'drug', 2126.0, 2132.0, 2138.0, 2144.0, 2150.0, 'http://sanchez.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2101, 2113.0, '1972-02-20', 'Emmett', '1976-06-24', 'http://dixon.com/', '463 Gomez Ways
Tommyfort, FM 79696', 'join', 2145.0, 2153.0, 2161.0, 2169.0, 2177.0, 'http://www.hunt.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2102, 2118.0, '1972-02-21', 'Emmett', '1976-06-25', 'http://www.moore-knight.org/', '2318 Lewis Ferry
West Carolyn, GU 16010', 'talk', 2164.0, 2174.0, 2184.0, 2194.0, 2204.0, 'https://www.mullen.com/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2096, 2067, 'Christina Gross', '1997-09-17');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2097, 2067, 'Monica Mcclain', '1997-09-15');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2098, 2067, 'Lynn Hess', '1997-09-16');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2127, 2067, 'Patricia Lewis', '1980-10-03');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2095, 2068, 'Monica Nicholson', '1997-09-17');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2128, 2068, 'Claire Obrien', '1980-10-04');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2129, 2068, 'John Robinson', '1980-10-05');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2130, 2068, 'Charles Aguilar', '1980-10-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Name FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DisplayName = 'Emmett' ORDER BY T1.Date DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Monica Nicholson',)
*/

-- Prediction Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Emmett' ORDER BY T2.Date DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Christina Gross',)
*/