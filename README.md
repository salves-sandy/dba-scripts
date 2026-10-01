# 🔍 Projeto 02: Análise de Índices Ausentes e Otimização de Performance

## 🎯 Contexto do Negócio
Com o crescimento contínuo da base de dados e do volume de consultas executadas pelos sistemas operacionais e relatórios de CX, consultas lentas e varreduras completas em tabelas (*Table Scans*) podem comprometer a performance geral do servidor de banco de dados.

O objetivo deste projeto de DBA é utilizar as visões de gerenciamento dinâmico (DMVs - *Dynamic Management Views*) nativas do SQL Server para identificar automaticamente:
1. **Índices Ausentes (*Missing Indexes*):** Sugestões de novos índices calculados pelo próprio Query Optimizer com base no histórico de consultas executadas.
2. **Índices Não Utilizados (*Unused Indexes*):** Identificação de índices redundantes que geram custo desnecessário de escrita (E/S e espaço em disco) sem trazer benefício para leitura.

---

## 🛠️ Tecnologias e Conceitos Utilizados
* **SGBD:** Microsoft SQL Server
* **Linguagem:** T-SQL (Transact-SQL)
* **DMVs / System Views:** `sys.dm_db_missing_index_details`, `sys.dm_db_missing_index_groups`, `sys.dm_db_missing_index_group_stats`, `sys.dm_db_index_usage_stats`.
* **Conceitos:** Otimização de Performance (*Index Tuning*), Custo de Leitura/Escrita, Redução de *Scans* para *Seeks*.

---

## 📂 Estrutura dos Arquivos
* `missing_indexes.sql`: Consulta T-SQL avançada que cruza DMVs para gerar automaticamente a instrução `CREATE INDEX` com base no custo/benefício e impacto estimado no banco de dados.
* `unused_indexes.sql`: Script para auditoria de uso dos índices existentes, permitindo a tomada de decisão segura para desativação ou remoção de índices obsoletos.
