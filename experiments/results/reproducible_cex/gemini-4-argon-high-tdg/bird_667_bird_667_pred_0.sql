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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 100, '2017-01-01 00:00:00', 'UserOne');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (2, 200, '2017-01-02 00:00:00', 'UserTwo');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate) VALUES (10, 1, '2018-01-01 00:00:00', 50, 500, 'Body 10', 1, '2018-02-01 00:00:00', 'Unlinked Earliest Post', '<sql>', 2, 1, 3, 1, '2018-01-15 00:00:00');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate) VALUES (20, 1, '2020-03-15 08:30:00', 5, 50, 'Body 20', 1, '2020-04-01 00:00:00', 'Alpha Post With One Link', '<db>', 1, 0, 1, 1, '2020-03-20 00:00:00');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate) VALUES (30, 1, '2019-05-10 12:00:00', 15, 200, 'Body 30', 2, '2022-06-01 00:00:00', 'Target Earliest Linked Post', '<join>', 3, 2, 4, 2, '2022-05-01 00:00:00');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate) VALUES (40, 1, '2021-11-20 16:45:00', 100, 900, 'Body 40', 2, '2023-12-01 00:00:00', 'Zeta Post With Three Links', '<index>', 5, 6, 10, 2, '2023-11-01 00:00:00');
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (100, '2020-04-01 00:00:00', 20, 10, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (301, '2023-01-01 00:00:00', 30, 10, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (302, '2023-01-02 00:00:00', 30, 20, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (401, '2023-12-01 00:00:00', 40, 10, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (402, '2023-12-02 00:00:00', 40, 20, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (403, '2023-12-03 00:00:00', 40, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title FROM posts AS T1 INNER JOIN postLinks AS T2 ON T2.PostId = T1.Id ORDER BY T1.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Target Earliest Linked Post',)
*/

-- Prediction Query
SELECT T2.Title FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id ORDER BY T1.CreationDate ASC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha Post With One Link',)
*/