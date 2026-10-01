-- ============================================================
-- PROJETO 01: ROTINA AUTOMATIZADA DE BACKUP (SQL SERVER)
-- Estratégia de Backup Full e Transaction Log
-- ============================================================

USE [master];
GO

-- ------------------------------------------------------------
-- 1. Execução de Backup FULL (Diário / Semanal)
-- Realiza a cópia completa do banco de dados com compressão ativada
-- ------------------------------------------------------------
DECLARE @DatabaseName NVARCHAR(100) = N'DB_Producao_CX';
DECLARE @BackupPath NVARCHAR(500);
DECLARE @FileName NVARCHAR(200);

-- Define o nome do arquivo com timestamp
SET @FileName = @DatabaseName + N'_FULL_' + CONVERT(NVARCHAR(20), GETDATE(), 112) + N'_' + REPLACE(CONVERT(NVARCHAR(20), GETDATE(), 108), ':', '') + N'.bak';
SET @BackupPath = N'C:\SQLBackups\Full\' + @FileName;

BACKUP DATABASE @DatabaseName
TO DISK = @BackupPath
WITH 
    NOFORMAT, 
    INIT, 
    NAME = N'Backup Full do Banco de Producao', 
    SKIP, 
    NOREWIND, 
    NOUNLOAD, 
    COMPRESSION, -- Reduz o tamanho do arquivo em disco
    STATS = 10;   -- Exibe o progresso a cada 10%
GO


-- ------------------------------------------------------------
-- 2. Execução de Backup do LOG DE TRANSAÇÕES (A cada 15 ou 30 min)
-- Permite recuperação Point-In-Time (em um minuto exato antes de uma falha)
-- ------------------------------------------------------------
DECLARE @DatabaseName NVARCHAR(100) = N'DB_Producao_CX';
DECLARE @BackupPath NVARCHAR(500);
DECLARE @FileName NVARCHAR(200);

SET @FileName = @DatabaseName + N'_LOG_' + CONVERT(NVARCHAR(20), GETDATE(), 112) + N'_' + REPLACE(CONVERT(NVARCHAR(20), GETDATE(), 108), ':', '') + N'.trn';
SET @BackupPath = N'C:\SQLBackups\Log\' + @FileName;

BACKUP LOG @DatabaseName
TO DISK = @BackupPath
WITH 
    NOFORMAT, 
    NOINIT, 
    NAME = N'Backup Transaction Log', 
    NOSKIP, 
    NOUNLOAD, 
    COMPRESSION, 
    STATS = 25;
GO
