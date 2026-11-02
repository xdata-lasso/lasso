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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'Necromancer', 'Necromancer', NULL, 1, 0, 11, 1, 10, 'default2'), (0, 11, NULL, 'Necromancer', NULL, NULL, 'Necromancer', NULL, 1, 10, 1, 10, 10, 'default1'), (11, 10, '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 'default1', 'default1', NULL, 0, 11, 10, NULL, 'default2'), (9, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'Necromancer', 'default1', 'default1', 11, 0, NULL, 9, 0, 'default1'), (10, 1, NULL, 'default2', NULL, 'Necromancer', NULL, 'default1', 9, 9, 1, 11, 9, 'default1'), (2, 9, '2023-01-01 01:00:00.000000', 'Necromancer', NULL, 'default1', NULL, 'default2', 10, 11, 11, 0, 11, 'Necromancer'), (3, 0, NULL, 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default1', 10, 9, 9, NULL, 11, 'default1'), (4, 11, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'Necromancer', NULL, NULL, 0, 9, 1, NULL, 10, 'default1'), (5, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'default2', 'Necromancer', 11, 10, 9, 10, 1, 'default1'), (6, 9, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, 'Necromancer', 0, 10, 9, NULL, NULL, 'Necromancer');
INSERT INTO badges (id, userid, name, date) VALUES (0, 2, 'default2', '2023-01-01 00:00:00.000000'), (10, NULL, 'default1', '2023-01-01 00:00:00.000000'), (9, 10, 'Necromancer', '2023-01-01 00:00:00.000000'), (11, 9, 'default1', NULL), (1, 9, 'default2', '2023-01-01 00:00:00.000000'), (2, 3, 'default2', '2023-01-01 01:00:00.000000'), (3, 6, 'Necromancer', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Necromancer' LIMIT 10;

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT u.DisplayName FROM users AS u JOIN badges AS b ON u.Id = b.UserId WHERE b.Name = 'Necromancer' LIMIT 10;

/*
Prediction Result:
('default2',)
*/