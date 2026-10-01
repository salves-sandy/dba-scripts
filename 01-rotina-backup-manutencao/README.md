# 💾 Projeto 01: Rotina Automatizada de Backup e Manutenção Preventiva

## 🎯 Contexto do Negócio
A garantia da integridade e disponibilidade dos dados é um dos pilares mais críticos da infraestrutura de TI e banco de dados. Indisponibilidades não planejadas ou perda de dados geram impacto direto na experiência do cliente (CX), além de graves prejuízos financeiros e regulatórios.

Este projeto apresenta scripts em **T-SQL (SQL Server)** para automação de rotinas essenciais de DBA:
1. **Estratégia de Backup:** Automação de Backup Completo (*Full*) e Backup de Log de Transações (*Transaction Log*).
2. **Manutenção Preventiva:** Reorganização e reconstrução de índices fragmentados (*Defrag/Reindex*) e atualização de estatísticas de otimização de consultas.

---

## 🛠️ Tecnologias e Conceitos Utilizados
* **SGBD:** Microsoft SQL Server
* **Linguagem:** T-SQL / Scripts de Manutenção de DBA
* **Conceitos:** *Disaster Recovery*, Backup Full / Log, DMV (`sys.dm_db_index_physical_stats`), `ALTER INDEX REBUILD / REORGANIZE`, `UPDATE STATISTICS`.

---

## 📂 Estrutura dos Arquivos
* `backup_routine.sql`: Procedures e comandos T-SQL para execução de backups full e transacionais parametrizados.
* `maintenance_routine.sql`: Script inteligente para análise de fragmentação de índices e manutenção preventiva do banco de dados.
