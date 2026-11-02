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
-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'Vienna, Austria', '4', -734455130, 1744686505, -1633151678, -252690330, 1, 'uzhs');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -845863578, '2021-01-23 18:11:33+00:00', 'bnp', '2022-04-12 01:47:28+00:00', 'dpos', 'Vienna, Austria', 'ie5', -1209887326, -1399556171, 1038707349, 1419861592, 1, '4ecigce376n');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1031969798, '2022-01-22 16:14:13+00:00', 's5bbp02e', '2022-10-06 23:43:31+00:00', 'liqa1', 'Vienna, Austria', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1, '4ji7zwa');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 2123196517, '2025-11-10 22:24:59+00:00', 'w', '2024-12-22 09:14:04+00:00', 'rq13pyu', '8d99rljsl', 'b4yp5qi', -227162283, 2056419640, 222415430, 556727997, 1178000634, 'pz0f8jegd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'Vienna, Austria', 'value', 1, 1, 1, 1, NULL, 'value');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'rwbbp6luhvd', '2021-07-11 07:27:32+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 2, 'um5', '2023-11-07 12:14:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 2, 'zbuo4nrqrof', '2024-12-28 10:57:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, '1vy9uxj4', '2021-01-22 00:53:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 4, 'bdvlph', '2023-09-26 13:08:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 4, 'nd', '2022-03-02 18:03:57+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'nqcx5h', '2021-10-14 14:41:11+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'p', '2022-04-18 00:53:20+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 'tu0', '2020-06-29 02:04:50+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 5, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 6, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Age FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.Location = 'Vienna, Austria';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT users.age FROM users INNER JOIN badges ON users.id = badges.userid WHERE users.location = 'Vienna, Austria';

/*
Prediction Result:
(1,)
(None,)
*/