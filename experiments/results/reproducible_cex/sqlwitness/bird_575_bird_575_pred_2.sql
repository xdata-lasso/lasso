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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, 'SilentGhost', 'default2', 'default1', 0, 1, 1, NULL, 0, 'SilentGhost'), (0, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'SilentGhost', 'default1', 'default1', NULL, NULL, NULL, 0, 1, 'default1'), (2, 1, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default2', 'default2', 1, 1, 1, 1, NULL, 'default1'), (3, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 'default2', 'default1', NULL, 1, NULL, 1, NULL, NULL), (4, NULL, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', NULL, 1, NULL, 0, 1, 1, 'default2'), (5, NULL, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', 0, NULL, 0, 1, 0, 'SilentGhost'), (6, NULL, NULL, 'SilentGhost', '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 1, NULL, NULL, NULL, 1, 'SilentGhost'), (7, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'SilentGhost', 1, NULL, 0, 1, NULL, 'default2'), (8, 1, '2023-01-01 01:00:00.000000', 'SilentGhost', '2023-01-01 00:00:00.000000', 'SilentGhost', 'SilentGhost', 'default1', 1, 1, 0, 0, NULL, 'SilentGhost'), (9, 1, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'SilentGhost', 'default2', 1, 0, 1, NULL, 0, 'default1'), (10, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default2', 'SilentGhost', NULL, 1, NULL, 0, 1, 1, 'default1'), (11, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', NULL, 'SilentGhost', 1, 1, NULL, NULL, 0, 'SilentGhost'), (12, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 0, NULL, 1, 0, 0, 'SilentGhost'), (13, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', 'SilentGhost', 'default2', 'SilentGhost', 0, NULL, 1, 0, 0, 'default2'), (14, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'SilentGhost', 'default1', 'default2', NULL, NULL, NULL, NULL, 1, 'default2'), (15, 1, NULL, 'SilentGhost', '2023-01-01 00:00:00.000000', 'default2', 'default1', NULL, NULL, 0, 1, 1, 0, 'default2'), (16, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', NULL, NULL, NULL, 1, 0, NULL, 0, 'default2');
INSERT INTO badges (id, userid, name, date) VALUES (1, 12, 'default2', '2023-01-01 00:00:00.000000'), (0, 7, 'SilentGhost', '2023-01-01 00:00:00.000000'), (2, 14, NULL, '2023-01-01 01:00:00.000000'), (3, 6, 'SilentGhost', '2023-01-01 01:00:00.000000'), (4, 6, NULL, '2023-01-01 00:00:00.000000'), (5, 9, NULL, NULL), (6, 14, 'default1', '2023-01-01 00:00:00.000000'), (7, 6, NULL, NULL), (8, 1, NULL, '2023-01-01 00:00:00.000000'), (9, 8, 'default2', NULL), (10, 8, 'default1', '2023-01-01 00:00:00.000000'), (11, 9, 'SilentGhost', NULL), (12, 4, 'default1', NULL), (13, 7, NULL, '2023-01-01 00:00:00.000000'), (14, 8, 'default2', '2023-01-01 00:00:00.000000'), (15, 2, 'SilentGhost', NULL), (16, 4, 'default1', '2023-01-01 00:00:00.000000'), (17, 10, 'default2', '2023-01-01 01:00:00.000000'), (18, 1, 'default2', '2023-01-01 01:00:00.000000'), (19, 9, 'SilentGhost', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'SilentGhost';

/*
Gold Result:
('SilentGhost',)
(None,)
(None,)
('default2',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT "badges"."name" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "users"."displayname" = 'SilentGhost';

/*
Prediction Result:
('SilentGhost',)
(None,)
('default2',)
('default1',)
*/