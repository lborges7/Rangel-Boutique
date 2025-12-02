# Rangel Boutique - Banco de Dados (Projeto Acadêmico / Portfólio)

Este repositório contém os scripts SQL para criação, povoamento e manipulação do banco de dados do projeto **Rangel Boutique** — um e-commerce de roupas e acessórios femininos.

## Conteúdo
- `sql/01_create_schema.sql` — DDL para criar esquema e tabelas (PostgreSQL)
- `sql/02_insert_seed.sql` — Dados de exemplo (fictícios) para testes
- `sql/03_queries.sql` — Consultas demonstrativas (SELECT com JOINs, agregações)
- `sql/04_updates_deletes.sql` — Exemplos de UPDATE e DELETE
- `docs/DER_crowsfoot.png` — Diagrama Entidade-Relacionamento (Crow's Foot)
- `docs/modelo_relacional.png` — (opcional) imagem do modelo relacional final

## Instruções de execução (PostgreSQL / pgAdmin)
1. Crie um banco (ex.: `rangel_db`) e conecte no pgAdmin ou psql.
2. Execute:
   ```bash
   psql -U seu_usuario -d rangel_db -f sql/01_create_schema.sql
   psql -U seu_usuario -d rangel_db -f sql/02_insert_seed.sql
