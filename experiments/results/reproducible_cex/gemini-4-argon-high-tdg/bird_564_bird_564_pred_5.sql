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
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (1, 2, 5, 'PostBody1', 'PostTitle1', 0, 1, 0, 107829);
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (2, 1, 1, 'PostBody2', 'PostTitle2', 1, 2, 1, 107829);
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (3, 2, 1, 'PostBody3', 'PostTitle3', 1, 0, 1, 107829);
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (4, 2, 1, 'PostBody4', 'PostTitle4', 1, 1, 1, 107828);
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (5, 2, 1, 'PostBody5', 'PostTitle5', 1, 1, 1, 107830);
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (6, 2, 1, 'PostBody6', 'PostTitle6', 1, 1, 1, NULL);
INSERT INTO posts (Id, PostTypeId, Score, Body, Title, AnswerCount, CommentCount, FavoriteCount, ParentId) VALUES (7, 2, 1, 'PostBody7', 'PostTitle7', 1, NULL, 1, 107829);
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (101, 1, 0, 'Target Comment', 'User1');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (102, 2, 1, 'Decoy CommentCount 2 A', 'User2');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (103, 2, 1, 'Decoy CommentCount 2 B', 'User3');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (104, 3, 1, 'Decoy CommentCount 0', 'User4');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (105, 4, 1, 'Decoy ParentId 107828', 'User5');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (106, 5, 1, 'Decoy ParentId 107830', 'User6');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (107, 6, 1, 'Decoy ParentId NULL', 'User7');
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName) VALUES (108, 7, 1, 'Decoy CommentCount NULL', 'User8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.ParentId = 107829 AND T1.CommentCount = 1;

/*
Gold Result:
('Target Comment',)
*/

-- Prediction Query
SELECT comments.Text FROM posts JOIN comments ON posts.Id = comments.PostId WHERE posts.ParentId = 107829 GROUP BY comments.PostId HAVING COUNT(comments.Id) = 1;

/*
Prediction Result:
('Target Comment',)
('Decoy CommentCount 0',)
('Decoy CommentCount NULL',)
*/