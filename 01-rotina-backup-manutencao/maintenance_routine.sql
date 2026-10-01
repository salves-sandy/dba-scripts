-- ============================================================
-- PROJETO 01: MANUTENÇÃO PREVENTIVA DE ÍNDICES E ESTATÍSTICAS
-- Análise Inteligente de Fragmentação
-- ============================================================

USE [DB_Producao_CX];
GO

-- ------------------------------------------------------------
-- Script de Manutenção Condicional baseada no Nível de Fragmentação
-- Regra de Negócio de DBA:
--  - Fragmentação entre 10% e 30% -> ALTER INDEX REORGANIZE (Leve, online)
--  - Fragmentação superior a 30%  -> ALTER INDEX REBUILD (Completo)
-- ------------------------------------------------------------
DECLARE @TableName NVARCHAR(256);
DECLARE @IndexName NVARCHAR(256);
DECLARE @FragPercent FLOAT;
DECLARE @SQL NVARCHAR(MAX);

DECLARE IndexCursor CURSOR FOR
SELECT 
    OBJECT_NAME(s.[object_id]) AS TableName,
    i.name AS IndexName,
    s.avg_fragmentation_in_percent AS FragPercent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
WHERE s.avg_fragmentation_in_percent > 10.0
  AND i.name IS NOT NULL;

OPEN IndexCursor;
FETCH NEXT FROM IndexCursor INTO @TableName, @IndexName, @FragPercent;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @FragPercent > 30.0
    BEGIN
        -- Fragmentação alta: Reconstrução completa
        SET @SQL = N'ALTER INDEX [' + @IndexName + N'] ON [' + @TableName + N'] REBUILD WITH (ONLINE = ON);';
        PRINT N'Executando REBUILD no índice: ' + @IndexName + N' (' + CAST(ROUND(@FragPercent,2) AS VARCHAR) + N'%)';
    END
    ELSE
    BEGIN
        -- Fragmentação moderada: Reorganização leve
        SET @SQL = N'ALTER INDEX [' + @IndexName + N'] ON [' + @TableName + N'] REORGANIZE;';
        PRINT N'Executando REORGANIZE no índice: ' + @IndexName + N' (' + CAST(ROUND(@FragPercent,2) AS VARCHAR) + N'%)';
    END

    EXEC sp_executesql @SQL;

    FETCH NEXT FROM IndexCursor INTO @TableName, @IndexName, @FragPercent;
END;

CLOSE IndexCursor;
DEALLOCATE IndexCursor;
GO

-- ------------------------------------------------------------
-- Atualização de Estatísticas para o Otimizador de Consultas (Query Optimizer)
-- ------------------------------------------------------------
EXEC sp_updatestats;
GO
