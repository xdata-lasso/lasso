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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 99, NULL, NULL, NULL, 'Teacher', 'default1', 'default2', 1, 99, NULL, 100, 1, NULL), (0, 1, NULL, 'Teacher', NULL, NULL, 'default2', 'default2', 99, 99, 99, 101, 99, 'default2'), (101, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'Teacher', NULL, 1, 1, 100, 1, 0, 'default1'), (99, 0, NULL, NULL, NULL, NULL, 'Teacher', 'Teacher', 99, NULL, 99, 99, NULL, NULL), (100, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default2', NULL, 99, 1, 1, 99, 'default1'), (2, 100, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', 'Teacher', 'Teacher', NULL, 101, 0, 101, 1, 'default2'), (3, 99, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 'Teacher', 'default2', 0, 100, 1, 100, NULL, NULL), (4, 101, NULL, NULL, NULL, 'default2', 'default2', 'default1', 99, 100, 0, 0, 0, 'default1');
INSERT INTO badges (id, userid, name, date) VALUES (100, 1, 'Teacher', '2023-01-01 01:00:00.000000'), (99, 100, 'default2', '2023-01-01 01:00:00.000000'), (0, 0, 'Teacher', NULL), (101, 99, 'default2', '2023-01-01 01:00:00.000000'), (1, NULL, 'default1', '2023-01-01 01:00:00.000000'), (2, 2, NULL, '2023-01-01 00:00:00.000000'), (3, 1, 'Teacher', '2023-01-01 00:00:00.000000'), (4, 99, 'Teacher', NULL), (5, 99, 'default1', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) * 100 / (SELECT COUNT(Id) FROM users) FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Teacher';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (COUNT(DISTINCT UserId) * 100.0 / CAST((SELECT COUNT(Id) FROM users) AS REAL)) AS percentage FROM badges WHERE Name = 'Teacher';

/*
Prediction Result:
(37.5,)
*/