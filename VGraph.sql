USE MASTER
GO
DROP DATABASE IF EXISTS VGraph
GO
CREATE DATABASE VGraph
GO
USE VGraph
GO

CREATE TABLE Warehouses (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Capacity INT,
    Location NVARCHAR(300)
) AS NODE;

CREATE TABLE ProductionCenters (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Location NVARCHAR(300)
) AS NODE;

CREATE TABLE DeliveryPoints (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Location NVARCHAR(300)
) AS NODE;

CREATE TABLE Keeping AS EDGE;

CREATE TABLE Delivering AS EDGE;

CREATE TABLE Working AS EDGE;

-- ���������� ������� �������
INSERT INTO Warehouses (ID, Name, Capacity, Location)
VALUES
    (1, N'����� 1', 1000, N'������, ��. ���������, 1'),
    (2, N'����� 2', 800, N'�����-���������, ��. �����������, 5'),
    (3, N'����� 3', 1200, N'������������, ��. ��������, 10'),
    (4, N'����� 4', 1500, N'�����������, ��. ��������, 15'),
    (5, N'����� 5', 900, N'���������, ��. ��������, 20'),
    (6, N'����� 6', 1100, N'�����������, ��. �������������, 25'),
    (7, N'����� 7', 1300, N'������, ��. ��������, 30'),
    (8, N'����� 8', 1000, N'������, ��. ���������, 35'),
    (9, N'����� 9', 800, N'���, ��. �������, 40'),
    (10, N'����� 10', 1200, N'������-��-����, ��. ���������, 45');

-- ���������� ������� ���������������� �������
INSERT INTO ProductionCenters (ID, Name, Location)
VALUES
    (1, N'����� 1', N'������, ��. ����������������, 1'),
    (2, N'����� 2', N'�����-���������, ��. ������������, 5'),
    (3, N'����� 3', N'������������, ��. ����������������, 10'),
    (4, N'����� 4', N'�����������, ��. ����������������, 15'),
    (5, N'����� 5', N'���������, ��. ������������, 20'),
    (6, N'����� 6', N'�����������, ��. ������������, 25'),
    (7, N'����� 7', N'������, ��. ����������������, 30'),
    (8, N'����� 8', N'������, ��. ������������, 35'),
    (9, N'����� 9', N'���, ��. ����������������, 40'),
    (10, N'����� 10', N'������-��-����, ��. ����������������, 45');

-- ���������� ������� ����� ��������
INSERT INTO DeliveryPoints (ID, Name, Location)
VALUES
    (1, N'����� 1', N'������, ��. �����������, 1'),
    (2, N'����� 2', N'�����-���������, ��. ��������, 5'),
    (3, N'����� 3', N'������������, ��. �����������, 10'),
    (4, N'����� 4', N'�����������, ��. �����������, 15'),
    (5, N'����� 5', N'���������, ��. �����������, 20'),
    (6, N'����� 6', N'�����������, ��. ��������, 25'),
    (7, N'����� 7', N'������, ��. �����������, 30'),
    (8, N'����� 8', N'������, ��. �����������, 35'),
    (9, N'����� 9', N'���, ��. �����������, 40'),
    (10, N'����� 10', N'������-��-����, ��. �����������, 45');

	INSERT INTO Working ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Warehouses WHERE id = 1),
 (SELECT $node_id FROM Warehouses WHERE id = 2)),
 ((SELECT $node_id FROM Warehouses WHERE id = 10),
 (SELECT $node_id FROM Warehouses WHERE id = 5)),
 ((SELECT $node_id FROM Warehouses WHERE id = 2),
 (SELECT $node_id FROM Warehouses WHERE id = 9)),
 ((SELECT $node_id FROM Warehouses WHERE id = 3),
 (SELECT $node_id FROM Warehouses WHERE id = 1)),
 ((SELECT $node_id FROM Warehouses WHERE id = 3),
 (SELECT $node_id FROM Warehouses WHERE id = 6)),
 ((SELECT $node_id FROM Warehouses WHERE id = 4),
 (SELECT $node_id FROM Warehouses WHERE id = 2)),
 ((SELECT $node_id FROM Warehouses WHERE id = 5),
 (SELECT $node_id FROM Warehouses WHERE id = 4)),
 ((SELECT $node_id FROM Warehouses WHERE id = 6),
 (SELECT $node_id FROM Warehouses WHERE id = 7)),
 ((SELECT $node_id FROM Warehouses WHERE id = 6),
 (SELECT $node_id FROM Warehouses WHERE id = 8)),
 ((SELECT $node_id FROM Warehouses WHERE id = 8),
 (SELECT $node_id FROM Warehouses WHERE id = 3));
GO
SELECT *
FROM Working;

INSERT INTO Keeping ($from_id, $to_id)
VALUES ((SELECT $node_id FROM ProductionCenters WHERE ID = 1),
 (SELECT $node_id FROM Warehouses WHERE ID = 1)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 5),
 (SELECT $node_id FROM Warehouses WHERE ID = 1)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 8),
 (SELECT $node_id FROM Warehouses WHERE ID = 1)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 2),
 (SELECT $node_id FROM Warehouses WHERE ID = 2)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 3),
 (SELECT $node_id FROM Warehouses WHERE ID = 3)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 4),
 (SELECT $node_id FROM Warehouses WHERE ID = 3)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 6),
 (SELECT $node_id FROM Warehouses WHERE ID = 4)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 7),
 (SELECT $node_id FROM Warehouses WHERE ID = 4)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 1),
 (SELECT $node_id FROM Warehouses WHERE ID = 9)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 9),
 (SELECT $node_id FROM Warehouses WHERE ID = 4)),
 ((SELECT $node_id FROM ProductionCenters WHERE ID = 10),
 (SELECT $node_id FROM Warehouses WHERE ID = 9));
 GO
SELECT *
FROM Keeping;

INSERT INTO Delivering ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Warehouses WHERE ID = 1),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 6)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 5),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 1)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 8),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 7)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 2),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 2)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 3),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 5)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 4),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 3)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 6),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 4)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 7),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 2)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 1),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 9)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 9),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 8)),
 ((SELECT $node_id FROM Warehouses WHERE ID = 10),
 (SELECT $node_id FROM DeliveryPoints WHERE ID = 9));
 GO
SELECT *
FROM Delivering;

SELECT [Warehouse1].name, [Warehouse2].name
FROM Warehouses AS [Warehouse1]
	, Working
	, Warehouses AS Warehouse2
WHERE MATCH([Warehouse1]-(Working)->[Warehouse2])
	AND Warehouse1.name = N'����� 3';

SELECT w.name, dp.name
FROM Warehouses AS w
	, Delivering AS d
	, DeliveryPoints as dp
WHERE MATCH(w-(d)->dp)
AND w.name = N'����� 1';

SELECT w.name, pc.name
FROM Warehouses AS w
	, Keeping AS k
	, ProductionCenters as pc
WHERE MATCH(pc-(k)->w)
AND w.name = N'����� 1';

SELECT [Warehouse1].name, [Warehouse2].name
FROM Warehouses AS [Warehouse1]
	, Working
	, Warehouses AS Warehouse2
WHERE MATCH([Warehouse1]-(Working)->[Warehouse2])
	AND Warehouse1.name = N'����� 3';

SELECT w.name, pc.name
FROM Warehouses AS w
	, Keeping AS k
	, ProductionCenters as pc
WHERE MATCH(pc-(k)->w)
AND w.name = N'����� 3';

SELECT [Warehouse1].name
	, STRING_AGG([Warehouse2].name, '->') WITHIN GROUP (GRAPH PATH)
FROM Warehouses AS [Warehouse1]
	, Working FOR PATH AS w
	, Warehouses FOR PATH AS Warehouse2
WHERE MATCH(SHORTEST_PATH([Warehouse1](-(w)->[Warehouse2])+))
	AND Warehouse1.name = N'����� 6';

	SELECT [Warehouse1].name
	, STRING_AGG([Warehouse2].name, '->') WITHIN GROUP (GRAPH PATH)
FROM Warehouses AS [Warehouse1]
	, Working FOR PATH AS w
	, Warehouses FOR PATH AS Warehouse2
WHERE MATCH(SHORTEST_PATH([Warehouse1](-(w)->[Warehouse2]){1,3}))
	AND Warehouse1.name = N'����� 6';

SELECT [Warehouse1].ID AS IdFirst
	, [Warehouse1].name AS First
	, CONCAT(N'wares', [Warehouse1].id) AS [First image name]
	, Warehouse2.ID AS IdSecond
	, Warehouse2.name AS Second
	, CONCAT(N'wares', Warehouse2.id) AS [Second image name]
FROM Warehouses AS [Warehouse1]
	, Working AS w
	, Warehouses AS Warehouse2
WHERE MATCH(Warehouse1-(w)->Warehouse2);

SELECT [Warehouse].id AS IdFirst
	, [Warehouse].name AS First
	, CONCAT(N'wares', [Warehouse].id) AS [First image name]
	, DP.id AS IdSecond
	, DP.name AS Second
	, CONCAT(N'delivery', DP.id) AS [Second image name]
FROM Warehouses AS [Warehouse]
	, Delivering AS d
	, DeliveryPoints AS DP
WHERE MATCH(Warehouse-(d)->DP);

SELECT [Warehouse].id AS IdFirst
	, [Warehouse].name AS First
	, CONCAT(N'wares', [Warehouse].id) AS [First image name]
	, PC.id AS IdSecond
	, PC.name AS Second
	, CONCAT(N'center', PC.id) AS [Second image name]
FROM Warehouses AS [Warehouse]
	, Keeping AS k
	, ProductionCenters AS PC
WHERE MATCH(Warehouse<-(k)-PC);

select @@servername