# 🛡️ Projeto 03: Gestão de Permissões, Acessos e Segurança (LGPD)

## 🎯 Contexto do Negócio
A segurança de dados e o controle rigoroso de acessos são exigências críticas para conformidade legal (LGPD) e prevenção de vazamentos de dados de clientes (*PII - Personally Identifiable Information*). Conceder privilégios excessivos (como permissões diretas de escrita ou exclusão) a usuários finais ou aplicações aumenta os riscos de violação e inconsistência na base de dados.

O objetivo deste projeto de DBA é estabelecer uma política segura de governança de acesso no SQL Server baseada em:
1. **Modelagem por Papéis (*Role-Based Access Control - RBAC*):** Agrupamento de permissões granulares por função (ex.: Consulta, Escrita Operacional e Suporte CX), evitando concessão direta a usuários.
2. **Princípio do Menor Privilégio (*Least Privilege*):** Restrição de comandos destrutivos (`DROP`, `TRUNCATE`, `DELETE` irrestrito) e auditoria contínua de privilégios ativos na base.

---

## 🛠️ Tecnologias e Conceitos Utilizados
* **SGBD:** Microsoft SQL Server
* **Linguagem:** T-SQL
* **Comandos & Views:** `CREATE ROLE`, `GRANT`, `DENY`, `sys.database_permissions`, `sys.database_principals`.
* **Conceitos:** Governança de Acesso, RBAC, LGPD, Princípio do Menor Privilégio, Auditoria de Segurança.

---

## 📂 Estrutura dos Arquivos
* `role_based_security.sql`: Script T-SQL para criação de *Database Roles* customizadas (Leitura, Operacional CX e Suporte) com concessão de privilégios mínimos.
* `audit_permissions.sql`: Script de auditoria para mapear todas as permissões efetivas atribuídas a usuários e papéis na base de dados.
