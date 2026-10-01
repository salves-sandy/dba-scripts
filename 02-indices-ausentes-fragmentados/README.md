# 🔍 Projeto 02: Identificação de Índices Ausentes e Fragmentados

## 🎯 Contexto do Negócio
Com o crescimento contínuo da base de dados e do volume de consultas executadas pelos sistemas operacionais e relatórios de CX, consultas lentas e varreduras completas em tabelas (*Table Scans*) podem comprometer a performance geral do servidor de banco de dados.

O objetivo deste projeto de DBA é utilizar as visões de gerenciamento dinâmico (DMVs - *Dynamic Management Views*) nativas do SQL Server para identificar automaticamente:
1. **Índices Ausentes (*Missing Indexes*):** Sugestões de novos índices calculados pelo próprio Query Optimizer com base no histórico de consultas executadas.
2. **Índices Fragmentados (*Index Fragmentation*):** Diagnóstico do nível de degradação física dos índices existentes para priorização de manutenção.

---

## 🛠️ Tecnologias e Conceitos Utilizados
* **SGBD:** Microsoft SQL Server
* **Linguagem:** T-SQL
* **DMVs / System Views:** `sys.dm_db_missing_index_details`, `sys.dm_db_missing_index_groups`, `sys.dm_db_missing_index_group_stats`, `sys.dm_db_index_physical_stats`.
* **Conceitos:** Otimização de Performance (*Index Tuning*), Custo de Leitura/Escrita, Redução de *Scans* para *Seeks*, Fragmentação Física.

---

## 📂 Estrutura dos Arquivos
* `missing_indexes.sql`: Consulta T-SQL avançada que cruza DMVs para gerar automaticamente a instrução `CREATE INDEX` com base no custo/benefício e impacto estimado no banco de dados.
* `fragmented_indexes.sql`: Script para auditoria detalhada da fragmentação lógica e física dos índices existentes na base.
