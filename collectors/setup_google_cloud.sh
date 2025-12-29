#!/bin/bash
# Google Cloud Setup Helper Script
# Automates the entire setup process

set -e  # Exit on error

echo "=========================================="
echo "GOOGLE CLOUD SETUP FOR BIGQUERY"
echo "=========================================="
echo ""

# Check which Mac architecture
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Set Homebrew path based on architecture
if [ "$ARCH" = "arm64" ]; then
    BREW_PATH="/opt/homebrew/bin/brew"
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PATH="/usr/local/bin/brew"
    BREW_PREFIX="/usr/local"
fi

echo "Expected Homebrew location: $BREW_PATH"
echo ""

# Check if Homebrew is installed
if [ ! -f "$BREW_PATH" ]; then
    echo "❌ Homebrew not found at $BREW_PATH"
    echo ""
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH
    echo "Adding Homebrew to PATH..."
    if [ "$ARCH" = "arm64" ]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

echo "✅ Homebrew found"
echo ""

# Install Google Cloud SDK
echo "Installing Google Cloud SDK..."
if ! $BREW_PATH list google-cloud-sdk &>/dev/null; then
    $BREW_PATH install google-cloud-sdk
    echo "✅ Google Cloud SDK installed"
else
    echo "✅ Google Cloud SDK already installed"
fi

# Add gcloud to PATH
echo ""
echo "Configuring gcloud in PATH..."
GCLOUD_PATH="$BREW_PREFIX/share/google-cloud-sdk"

if [ -f "$GCLOUD_PATH/path.zsh.inc" ]; then
    # Check if already in .zshrc
    if ! grep -q "google-cloud-sdk/path.zsh.inc" ~/.zshrc 2>/dev/null; then
        echo "source '$GCLOUD_PATH/path.zsh.inc'" >> ~/.zshrc
    fi
    source "$GCLOUD_PATH/path.zsh.inc"
    echo "✅ gcloud added to PATH"
else
    echo "⚠️  Warning: gcloud path file not found"
fi

echo ""
echo "=========================================="
echo "✅ INSTALLATION COMPLETE"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Initialize Google Cloud (browser will open):"
echo "   gcloud init"
echo ""
echo "   - Sign in with your Google account"
echo "   - Create new project: 'deep-tech-database'"
echo ""
echo "2. Enable BigQuery API:"
echo "   gcloud services enable bigquery.googleapis.com"
echo ""
echo "3. Set up authentication (browser will open):"
echo "   gcloud auth application-default login"
echo ""
echo "4. Run the collector:"
echo "   python3 1_google_patents_collector.py"
echo ""
echo "=========================================="
