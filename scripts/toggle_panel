#!/bin/bash

qdbus6 org.kde.plasmashell /PlasmaShell evaluateScript 'let panel = panelById(2);

panel.hiding === "autohide" ? panel.hiding = "alwaysvisible" : panel.hiding = "autohide";'

# plasmashell --replace &
