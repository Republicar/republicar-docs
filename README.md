# 📘 Documentação: Gestão de Repúblicas

![Docs System](https://img.shields.io/badge/Docs-MkDocs-blue?style=for-the-badge&logo=materialformkdocs)
![Python](https://img.shields.io/badge/Python-3.8%2B-yellow?style=for-the-badge&logo=python)
![Status](https://img.shields.io/badge/Status-V1.0-green?style=for-the-badge)

Este repositório contém toda a documentação técnica, regras de negócio e backlog da **Plataforma de Gestão de Repúblicas**. 

O objetivo é centralizar o conhecimento do projeto, servindo como guia único para o desenvolvimento e manutenção do sistema.

---

## 🗂️ Conteúdo da Documentação

O site gerado cobre os seguintes tópicos:

* **Planejamento:** Backlog do Produto (Épicos e Histórias de Usuário).
* **Regras de Negócio:** Detalhamento lógico dos cálculos de divisão (Igualitária vs. Proporcional).
* **Arquitetura:** Diagramas de banco de dados e stack tecnológica.
* **Guias:** Instruções de instalação e manuais de uso.

---

## 🚀 Como Rodar Localmente

Este projeto utiliza **MkDocs** com o tema **Material**. Para facilitar o gerenciamento de dependências, utilizamos um `Makefile` que configura um ambiente virtual Python (`venv`).

### Pré-requisitos

* **Python 3.8** ou superior instalado.
* **Make** (Geralmente nativo em Linux/Mac. No Windows, necessário WSL ou GnuWin32, ou rodar os comandos do Makefile manualmente).

### Passo a Passo

1.  **Instalação do Ambiente:**
    Este comando cria a pasta `venv`, ativa o ambiente virtual e instala as dependências listadas no `pyproject.toml`.
    ```bash
    make install
    ```

2.  **Rodar o Servidor de Desenvolvimento:**
    Inicia o servidor local com *hot-reload* (atualização automática ao salvar arquivos).
    ```bash
    make serve
    ```
    > O site estará disponível em: [http://localhost:8000](http://localhost:8000)

3.  **Limpar o Ambiente (Opcional):**
    Caso precise remover o ambiente virtual para reinstalar do zero.
    ```bash
    make clean
    ```

---

## 📦 Deploy

O projeto está configurado para ser hospedado no **GitHub Pages**.

Para compilar a versão estática e enviar para a branch `gh-pages` automaticamente:

```bash
make gh-deploy
```

## 🛠️ Estrutura do Projeto
``` plaintext
.
├── docs/               # Arquivos Markdown (.md) com o conteúdo
│   ├── img/            # Imagens e diagramas
│   ├── index.md        # Página inicial
│   └── ...
├── mkdocs.yml          # Configuração global do site (tema, navegação)
├── Makefile            # Automação de comandos
├── pyproject.toml      # Lista de dependências Python
└── README.md           # Este arquivo
```

## 📝 Como Contribuir
Edite os arquivos .md dentro da pasta docs/.

Use o make serve para visualizar as alterações em tempo real.

Siga o padrão de formatação do Material for MkDocs (admonitions, tabelas, etc).
