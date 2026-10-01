-- ============================================================
-- PROJETO 02: IDENTIFICAÇÃO DE ÍNDICES AUSENTES (MISSING INDEXES)
-- Consulta em DMVs para sugerir criação de índices de alto impacto
-- ============================================================

USE [DB_Producao_CX];
GO

SELECT 
    -- Cálculo do impacto estimado do índice na performance geral do banco
    ROUND(migs.avg_total_user_cost * (migs.avg_user_impact / 100.0) * (migs.user_seeks + migs.user_scans), 2) AS impacto_estimado,
    
    -- Informações da tabela e colunas recomendadas
    db_name(mid.database_id) AS nome_banco,
    OBJECT_NAME(mid.object_id, mid.database_id) AS nome_tabela,
    mid.equality_columns AS colunas_igualdade,
    mid.inequality_columns AS colunas_desigualdade,
    mid.included_columns AS colunas_incluidas_include,
    
    -- Métrica de uso
    migs.user_seeks AS buscas_potenciais,
    migs.avg_user_impact AS porcentagem_melhoria_esperada,
    
    -- Script T-SQL pré-formatado para criação dinâmica do índice
    'CREATE INDEX [IX_' + OBJECT_NAME(mid.object_id, mid.database_id) + '_' + 
    REPLACE(REPLACE(REPLACE(ISNULL(mid.equality_columns, mid.inequality_columns), '[', ''), ']', ''), ', ', '_') + ']' +
    ' ON ' + mid.statement + 
    ' (' + ISNULL(mid.equality_columns, '') + 
    CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns IS NOT NULL THEN ', ' ELSE '' END + 
    ISNULL(mid.inequality_columns, '') + ')' + 
    ISNULL(' INCLUDE (' + mid.included_columns + ')', '') AS script_criacao_sugerido

FROM sys.dm_db_missing_index_groups mig
INNER JOIN sys.dm_db_missing_index_group_stats migs 
    ON migs.group_handle = mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details mid 
    ON mig.index_handle = mid.index_handle
WHERE mid.database_id = DB_ID()
ORDER BY impacto_estimado DESC;
GO
