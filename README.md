<div align="center">
  <h1>⚙️ DBA Scripts & Manutenção de Banco de Dados</h1>
  <p><strong>Repositório focado em scripts T-SQL para administração de bancos de dados, backup, segurança, monitoramento de performance e otimização em SQL Server e MySQL.</strong></p>

  <p>
    <img src="https://img.shields.io/badge/Database-SQL%20Server%20%7C%20MySQL-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" alt="Databases" />
    <img src="https://img.shields.io/badge/Focus-DBA%20%26%20Database%20Administration-0A66C2?style=for-the-badge" alt="Focus" />
  </p>
</div>

---

## 📌 Sobre este repositório

Coleção de scripts de automação e rotinas de Administração de Banco de Dados (DBA). O objetivo é garantir a alta disponibilidade, performance, segurança e integridade dos dados que alimentam os sistemas operacionais e de Customer Experience.

---

## 🚀 Projetos de DBA

| # | Projeto | Foco Principal | Conceitos & Ferramentas | Status |
| :-: | :--- | :--- | :--- | :-: |
| 01 | [`01-rotina-backup-manutencao`](./01-rotina-backup-manutencao) | Rotina de Backup & Manutenção | Backup Full/Log, Defrag/Reindex, DMVs, `sp_updatestats` | ✅ Concluído |
| 02 | [`02-indices-ausentes-fragmentados`](./02-indices-ausentes-fragmentados) | Análise de Índices Ausentes | DMVs (`sys.dm_db_missing_index_*`), Index Tuning, T-SQL | ✅ Concluído |
| 03 | [`03-permissoes-seguranca-lgpd`](./03-permissoes-seguranca-lgpd) | Gestão de Acessos & LGPD | RBAC, `GRANT/DENY`, Auditoria, T-SQL | ✅ Concluído |
| 04 | `04-monitoramento-locks-deadlocks` | Monitoramento de Locks | `sp_who2`, `sys.dm_exec_requests`, Resolução de bloqueios | ⏳ Em breve |
| 05 | `05-purga-logs-expurgo` | Purga Segura de Dados Antigos | Exclusão em lotes (`WHILE`, `DELETE TOP`), Transaction Log | ⏳ Em breve |

---

<div align="center">
  <sub>Desenvolvido por <strong>Sandy Alves</strong> · Conecte-se comigo no <a href="https://linkedin.com/in/SEU_LINKEDIN">LinkedIn</a></sub>
</div>
* `missing_indexes.sql`: Consulta T-SQL avançada que cruza DMVs para gerar automaticamente a instrução `CREATE INDEX` com base no custo/benefício e impacto estimado no banco de dados.
* `unused_indexes.sql`: Script para auditoria de uso dos índices existentes, permitindo a tomada de decisão segura para desativação ou remoção de índices obsoletos.
