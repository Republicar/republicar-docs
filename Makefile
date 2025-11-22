# Makefile for managing an MkDocs project with the Material theme using a Python venv.

# --- Configuration ---
# Name of the virtual environment directory.
VENV_DIR := venv
# Path to the Python interpreter within the venv.
# This uses 'bin' for Linux/macOS. For Windows, it would be 'Scripts'.
PYTHON := $(VENV_DIR)/bin/python
# The port on your local machine that will be used to access the dev server.
PORT ?= 8000


# The default command to run when you just type "make".
.DEFAULT_GOAL := help

# --- Targets ---

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install     Create a virtual environment and install dependencies from pyproject.toml."
	@echo "  serve       Start a live-reloading dev server at http://localhost:$(PORT)."
	@echo "  gh-deploy   Build and deploy the site to GitHub Pages."
	@echo "  clean       Remove the Python virtual environment directory."
	@echo ""
	@echo "You can override the port by running: make serve PORT=8080"


.PHONY: install
install:
	@echo "--> Creating Python virtual environment in './$(VENV_DIR)'..."
	python3 -m venv $(VENV_DIR)
	@echo "--> Installing dependencies from pyproject.toml..."
	$(PYTHON) -m pip install --upgrade pip
	@# This command tells pip to install the project in the current directory,
	@# reading its dependencies from the [project] section of pyproject.toml.
	$(PYTHON) -m pip install .


.PHONY: serve
serve:
	@echo "--> Starting development server on http://localhost:$(PORT)"
	@echo "--> Press CTRL+C to stop the server."
	$(PYTHON) -m mkdocs serve --dev-addr localhost:$(PORT)


.PHONY: gh-deploy
gh-deploy:
	@echo "--> Deploying site to GitHub Pages..."
	$(PYTHON) -m mkdocs gh-deploy


.PHONY: clean
clean:
	@echo "--> Removing virtual environment directory..."
	rm -rf $(VENV_DIR)
