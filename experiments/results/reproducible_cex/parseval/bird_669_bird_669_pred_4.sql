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
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'chl', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1179823637, '2021-09-24 11:50:48+00:00', 'chl', '2025-01-09 01:18:18+00:00', 'rqrofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1909986641, '2023-01-13 04:58:30+00:00', 'chl', '2024-12-22 09:14:04+00:00', 'rq13pyu', '8d99rljsl', 'b4yp5qi', -227162283, 2056419640, 222415430, 556727997, 1178000634, 'pz0f8jegd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1675430660, '2022-11-21 09:24:31+00:00', '9uxj4hw', '2020-03-11 08:08:02+00:00', 'v', 'ph2', 'nd', -1052964641, -1245682094, -1660358170, -1106350634, -1509264256, '0dz79f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, 1038566008, '2025-03-26 10:17:14+00:00', 'chl', '2025-07-07 23:31:04+00:00', '6vck', 'ah0f8jsww', 'q7x', -541746689, 1294666887, -515895469, 1427161052, 564390026, '6nijjai5dh');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -946046410, '2025-05-12 19:10:13+00:00', 'chl', '2025-08-29 09:03:05+00:00', 'sj3ay', 'p1q430', 'jh3den8', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, '1of77p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'chl', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1, -2147483648, -443340271, '2024-06-15', 1, 757448742);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, -2147483648, -1438850342, '2024-06-15', 1, -305670381);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, -2147483648, 105869088, '2024-06-15', 1, -2081315180);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-1, -2147483648, -1485777725, '2024-06-15', 4, -1255130038);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (0, -2147483648, -1056308489, '1970-01-02', 4, -1454058168);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (4, -2147483648, -1437333179, '2023-03-15', 2, -664303813);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (5, -2147483648, -1910425938, '2023-05-26', 3, -841692980);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (6, -2147483648, 1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreationDate FROM users AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'chl' ORDER BY T2.CreationDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT MIN(T1.CreationDate) FROM votes AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DisplayName = 'chl';

/*
Prediction Result:
('2023-05-26',)
*/