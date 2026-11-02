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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (10, 100, '2023-01-01 00:00:00', 'Alice');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (20, 200, '2023-06-01 00:00:00', 'Bob');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (30, 300, '2023-12-01 00:00:00', 'Charlie');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, CommentCount, Title) VALUES (101, 1, 10, 50, 'Post 101');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, CommentCount, Title) VALUES (102, 1, 10, 60, 'Post 102');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, CommentCount, Title) VALUES (103, 1, 10, 70, 'Post 103 No Comments');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, CommentCount, Title) VALUES (201, 2, 20, 80, 'Post 201');
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (1001, 101, 1, 'Anon comment on 101', '2023-01-02 00:00:00', NULL);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (1002, 101, 2, 'Bob comment on 101', '2023-01-03 00:00:00', 20);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (1003, 102, 3, 'Alice comment on 102', '2023-01-04 00:00:00', 10);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (2001, 201, 4, 'Alice comment on 201', '2023-06-02 00:00:00', 10);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (2002, 201, 5, 'Bob comment on 201', '2023-06-03 00:00:00', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T3.PostId = T2.Id ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COALESCE((SELECT COUNT(*) FROM posts WHERE OwnerUserId = (SELECT Id FROM users ORDER BY CreationDate DESC, users.id NULLS LAST LIMIT 1)), 0) AS PostCount, COALESCE((SELECT COUNT(*) FROM comments WHERE UserId = (SELECT Id FROM users ORDER BY CreationDate DESC, users.id NULLS LAST LIMIT 1)), 0) AS CommentCount;

/*
Prediction Result:
(0, 0)
*/