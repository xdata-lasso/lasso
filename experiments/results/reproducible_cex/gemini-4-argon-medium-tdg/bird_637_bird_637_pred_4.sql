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
-- DATASET 1
-- Core positive case vs. wrong join path (joining users directly to posts.OwnerUserId or LastEditorUserId instead of via postHistory)
INSERT INTO users (Id, DisplayName) VALUES (1, 'Mark Meckes');
INSERT INTO users (Id, DisplayName) VALUES (2, 'Alice');
-- Post 101: Owned/Edited by Alice, but postHistory belongs to Mark Meckes (Should be returned)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CommentCount, Tags) VALUES (101, 2, 2, 0, '<math><probability>');
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1001, 101, 1);
-- Post 102: Owned and edited by Mark Meckes, but postHistory belongs to Alice (Should NOT be returned)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CommentCount, Tags) VALUES (102, 1, 1, 0, '<wrong-join-path>');
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1002, 102, 2);
-- Post 103: Owned by Mark Meckes, no postHistory at all (Tests missing postHistory join)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CommentCount, Tags) VALUES (103, 1, 1, 0, '<no-history>');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T3.Id = T2.PostId WHERE T1.DisplayName = 'Mark Meckes' AND T3.CommentCount = 0;

/*
Gold Result:
('<math><probability>',)
*/

-- Prediction Query
WITH RECURSIVE split_tags(post_id, tag, rest) AS (SELECT p.Id, TRIM(SUBSTRING(p.Tags, 2, IIF(INSTR(SUBSTRING(p.Tags, 1), '>') = 0, 0, INSTR(SUBSTRING(p.Tags, 1), '>') + 1 - 1) - 2)), SUBSTRING(p.Tags, IIF(INSTR(SUBSTRING(p.Tags, 1), '>') = 0, 0, INSTR(SUBSTRING(p.Tags, 1), '>') + 1 - 1) + 1) FROM posts AS p WHERE p.OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Mark Meckes') AND p.CommentCount = 0 AND NOT p.Tags IS NULL UNION ALL SELECT post_id, TRIM(SUBSTRING(rest, 2, IIF(INSTR(SUBSTRING(rest, 1), '>') = 0, 0, INSTR(SUBSTRING(rest, 1), '>') + 1 - 1) - 2)), SUBSTRING(rest, IIF(INSTR(SUBSTRING(rest, 1), '>') = 0, 0, INSTR(SUBSTRING(rest, 1), '>') + 1 - 1) + 1) FROM split_tags WHERE LENGTH(rest) > 0) SELECT DISTINCT tag FROM split_tags WHERE LENGTH(tag) > 0;

/*
Prediction Result:
('wrong-join-path',)
('no-history',)
*/