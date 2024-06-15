# Install homebrew dependencies
brew bundle install

# Install dependencies via Mise.
mise install

# Generate the Tusit project.
mise x -- tuist generate
