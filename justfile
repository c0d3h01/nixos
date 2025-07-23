# Variables
user := `whoami`
host := `hostname`

# Rebuild Home Manager configuration
home:
    @echo "Switching Home Manager for {{user}}@{{host}}..."
    nh home switch || home-manager switch --flake ".#{{user}}@{{host}}"
