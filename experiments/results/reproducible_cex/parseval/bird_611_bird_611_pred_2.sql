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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, 1, '2024-12-15 00:56:33+00:00', '5k5swwqcgsk9', '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 'bnp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2021-02-17 05:47:13+00:00', 'e5u', '2021-11-09 05:42:50+00:00', '6klfa9', '00t5c4e', 'cigce376nium', 283598170, 742285925, -747753377, 902887186, -967741825, 'fqyp5s5bbp0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1, '2020-12-13 17:48:30+00:00', '72k', '2021-07-01 18:29:24+00:00', 'x1', 'ji7zwau2', 'dwyrq13pyu78', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 556727997, '2024-02-28 14:45:41+00:00', 'pz0f8jegd', '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, -1264842910, -1052964641, -1245682094, 'x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, NULL, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'mdpos', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 2, '2eutliqa11r', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 2, 'ytoo3o9', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, '5hncprjtu0d', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 4, '79fjgq8', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 4, 'n2f3dqv0gcb9', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'ozk3zbily', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'kn6vc', '2010-07-19 19:39:08.0');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, '6ah', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 5, 'value', NULL);

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 6, '5k5swwqcgs', '2010-07-19 19:39:08.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Reputation FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Date = '2010-07-19 19:39:08.0';

/*
Gold Result:
(1,)
(1,)
(1,)
(556727997,)
(556727997,)
(556727997,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT users.reputation FROM users INNER JOIN badges ON users.id = badges.userid WHERE badges.date = '2010-07-19 19:39:08.0';

/*
Prediction Result:
(1,)
(556727997,)
(None,)
*/