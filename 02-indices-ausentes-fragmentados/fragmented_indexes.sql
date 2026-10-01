-- ============================================================
-- PROJETO 02: DIAGNÓSTICO DE FRAGMENTAÇÃO DE ÍNDICES
-- Relatório de degradação física para priorização de Defrag/Reindex
-- ============================================================

USE [DB_Producao_CX];
GO

SELECT 
    OBJECT_NAME(ps.object_id) AS nome_tabela,
    i.name AS nome_indice,
    ps.index_type_desc AS tipo_indice,
    ROUND(ps.avg_fragmentation_in_percent, 2) AS porcentagem_fragmentacao,
    ps.page_count AS total_paginas,
    
    -- Recomendação automatizada de ação para o DBA
    CASE 
        WHEN ps.avg_fragmentation_in_percent > 30 THEN 'REBUILD (Reconstrução Completa)'
        WHEN ps.avg_fragmentation_in_percent BETWEEN 10 AND 30 THEN 'REORGANIZE (Reorganização Leve)'
        ELSE 'SAUDÁVEL (Nenhuma ação necessária)'
    END AS acao_recomendada
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
INNER JOIN sys.indexes i 
    ON ps.object_id = i.object_id 
   AND ps.index_id = i.index_id
WHERE ps.index_id > 0 -- Descarta tabelas HEAP (sem índice clusterizado)
  AND ps.page_count > 100 -- Filtra apenas tabelas relevantes em tamanho
ORDER BY ps.avg_fragmentation_in_percent DESC;
GO
