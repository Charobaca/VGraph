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

-- Заполнение таблицы складов
INSERT INTO Warehouses (ID, Name, Capacity, Location)
VALUES
    (1, N'Склад 1', 1000, N'Москва, ул. Складская, 1'),
    (2, N'Склад 2', 800, N'Санкт-Петербург, ул. Хранилищная, 5'),
    (3, N'Склад 3', 1200, N'Екатеринбург, ул. Грузовая, 10'),
    (4, N'Склад 4', 1500, N'Новосибирск, ул. Хранения, 15'),
    (5, N'Склад 5', 900, N'Краснодар, ул. Запасная, 20'),
    (6, N'Склад 6', 1100, N'Владивосток, ул. Складирования, 25'),
    (7, N'Склад 7', 1300, N'Казань, ул. Поставки, 30'),
    (8, N'Склад 8', 1000, N'Самара, ул. Заготовок, 35'),
    (9, N'Склад 9', 800, N'Уфа, ул. Закупки, 40'),
    (10, N'Склад 10', 1200, N'Ростов-на-Дону, ул. Складская, 45');

-- Заполнение таблицы производственных центров
INSERT INTO ProductionCenters (ID, Name, Location)
VALUES
    (1, N'Центр 1', N'Москва, ул. Производственная, 1'),
    (2, N'Центр 2', N'Санкт-Петербург, ул. Производства, 5'),
    (3, N'Центр 3', N'Екатеринбург, ул. Производительная, 10'),
    (4, N'Центр 4', N'Новосибирск, ул. Производственная, 15'),
    (5, N'Центр 5', N'Краснодар, ул. Промышленная, 20'),
    (6, N'Центр 6', N'Владивосток, ул. Производства, 25'),
    (7, N'Центр 7', N'Казань, ул. Производственная, 30'),
    (8, N'Центр 8', N'Самара, ул. Производства, 35'),
    (9, N'Центр 9', N'Уфа, ул. Производственная, 40'),
    (10, N'Центр 10', N'Ростов-на-Дону, ул. Производственная, 45');

-- Заполнение таблицы точек доставки
INSERT INTO DeliveryPoints (ID, Name, Location)
VALUES
    (1, N'Точка 1', N'Москва, ул. Доставочная, 1'),
    (2, N'Точка 2', N'Санкт-Петербург, ул. Доставки, 5'),
    (3, N'Точка 3', N'Екатеринбург, ул. Доставочная, 10'),
    (4, N'Точка 4', N'Новосибирск, ул. Доставочная, 15'),
    (5, N'Точка 5', N'Краснодар, ул. Доставочная, 20'),
    (6, N'Точка 6', N'Владивосток, ул. Доставки, 25'),
    (7, N'Точка 7', N'Казань, ул. Доставочная, 30'),
    (8, N'Точка 8', N'Самара, ул. Доставочная, 35'),
    (9, N'Точка 9', N'Уфа, ул. Доставочная, 40'),
    (10, N'Точка 10', N'Ростов-на-Дону, ул. Доставочная, 45');

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
	AND Warehouse1.name = N'Склад 3';

SELECT w.name, dp.name
FROM Warehouses AS w
	, Delivering AS d
	, DeliveryPoints as dp
WHERE MATCH(w-(d)->dp)
AND w.name = N'Склад 1';

SELECT w.name, pc.name
FROM Warehouses AS w
	, Keeping AS k
	, ProductionCenters as pc
WHERE MATCH(pc-(k)->w)
AND w.name = N'Склад 1';

SELECT [Warehouse1].name, [Warehouse2].name
FROM Warehouses AS [Warehouse1]
	, Working
	, Warehouses AS Warehouse2
WHERE MATCH([Warehouse1]-(Working)->[Warehouse2])
	AND Warehouse1.name = N'Склад 3';

SELECT w.name, pc.name
FROM Warehouses AS w
	, Keeping AS k
	, ProductionCenters as pc
WHERE MATCH(pc-(k)->w)
AND w.name = N'Склад 3';

SELECT [Warehouse1].name
	, STRING_AGG([Warehouse2].name, '->') WITHIN GROUP (GRAPH PATH)
FROM Warehouses AS [Warehouse1]
	, Working FOR PATH AS w
	, Warehouses FOR PATH AS Warehouse2
WHERE MATCH(SHORTEST_PATH([Warehouse1](-(w)->[Warehouse2])+))
	AND Warehouse1.name = N'Склад 6';

	SELECT [Warehouse1].name
	, STRING_AGG([Warehouse2].name, '->') WITHIN GROUP (GRAPH PATH)
FROM Warehouses AS [Warehouse1]
	, Working FOR PATH AS w
	, Warehouses FOR PATH AS Warehouse2
WHERE MATCH(SHORTEST_PATH([Warehouse1](-(w)->[Warehouse2]){1,3}))
	AND Warehouse1.name = N'Склад 6';

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