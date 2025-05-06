powershell -ExecutionPolicy Bypass -File create-project-structure.sh

# Flutter Jump-Off Platform Directory Structure Script (PowerShell)
# Creates the directory structure for a Flutter project

# Function to create a directory and output status
function Create-Directory {
    param (
        [string]$Path
    )
    
    if (-not (Test-Path -Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
        Write-Host "Created directory: $Path" -ForegroundColor Green
    }
}

# Main function to create project structure
function Create-ProjectStructure {
    Write-Host "Creating Jump-Off Platform directory structure..." -ForegroundColor Cyan
    
    # Create project root
    $projectName = "jump_off_platform"
    Create-Directory -Path $projectName
    Set-Location -Path $projectName
    
    # Create lib directory (main project source code)
    Create-Directory -Path "lib"
    
    # Create core directory structure
    Create-Directory -Path "lib\core\config\theme"
    Create-Directory -Path "lib\core\constants"
    Create-Directory -Path "lib\core\di"
    Create-Directory -Path "lib\core\error"
    Create-Directory -Path "lib\core\network"
    Create-Directory -Path "lib\core\utils\extensions"
    Create-Directory -Path "lib\core\utils\helpers"
    Create-Directory -Path "lib\core\utils\mixins"
    
    # Create features directory structure
    # Authentication feature
    Create-Directory -Path "lib\features\authentication\data\datasources"
    Create-Directory -Path "lib\features\authentication\data\models"
    Create-Directory -Path "lib\features\authentication\data\repositories"
    Create-Directory -Path "lib\features\authentication\domain\entities"
    Create-Directory -Path "lib\features\authentication\domain\repositories"
    Create-Directory -Path "lib\features\authentication\domain\usecases"
    Create-Directory -Path "lib\features\authentication\presentation\pages"
    Create-Directory -Path "lib\features\authentication\presentation\widgets"
    Create-Directory -Path "lib\features\authentication\presentation\bloc"
    
    # Onboarding feature
    Create-Directory -Path "lib\features\onboarding\data\datasources"
    Create-Directory -Path "lib\features\onboarding\data\models"
    Create-Directory -Path "lib\features\onboarding\data\repositories"
    Create-Directory -Path "lib\features\onboarding\domain\entities"
    Create-Directory -Path "lib\features\onboarding\domain\repositories"
    Create-Directory -Path "lib\features\onboarding\domain\usecases"
    Create-Directory -Path "lib\features\onboarding\presentation\pages"
    Create-Directory -Path "lib\features\onboarding\presentation\widgets"
    Create-Directory -Path "lib\features\onboarding\presentation\bloc"
    
    # Notifications feature
    Create-Directory -Path "lib\features\notifications\data\datasources"
    Create-Directory -Path "lib\features\notifications\data\models"
    Create-Directory -Path "lib\features\notifications\data\repositories"
    Create-Directory -Path "lib\features\notifications\domain\entities"
    Create-Directory -Path "lib\features\notifications\domain\repositories"
    Create-Directory -Path "lib\features\notifications\domain\usecases"
    Create-Directory -Path "lib\features\notifications\presentation\pages"
    Create-Directory -Path "lib\features\notifications\presentation\widgets"
    Create-Directory -Path "lib\features\notifications\presentation\bloc"
    
    # Analytics feature
    Create-Directory -Path "lib\features\analytics\data\datasources"
    Create-Directory -Path "lib\features\analytics\data\models"
    Create-Directory -Path "lib\features\analytics\data\repositories"
    Create-Directory -Path "lib\features\analytics\domain\entities"
    Create-Directory -Path "lib\features\analytics\domain\repositories"
    Create-Directory -Path "lib\features\analytics\domain\usecases"
    Create-Directory -Path "lib\features\analytics\presentation\pages"
    Create-Directory -Path "lib\features\analytics\presentation\widgets"
    Create-Directory -Path "lib\features\analytics\presentation\bloc"
    
    # In-app purchase feature
    Create-Directory -Path "lib\features\in_app_purchase\data\datasources"
    Create-Directory -Path "lib\features\in_app_purchase\data\models"
    Create-Directory -Path "lib\features\in_app_purchase\data\repositories"
    Create-Directory -Path "lib\features\in_app_purchase\domain\entities"
    Create-Directory -Path "lib\features\in_app_purchase\domain\repositories"
    Create-Directory -Path "lib\features\in_app_purchase\domain\usecases"
    Create-Directory -Path "lib\features\in_app_purchase\presentation\pages"
    Create-Directory -Path "lib\features\in_app_purchase\presentation\widgets"
    Create-Directory -Path "lib\features\in_app_purchase\presentation\bloc"
    
    # Create shared directory structure
    Create-Directory -Path "lib\shared\widgets\buttons"
    Create-Directory -Path "lib\shared\widgets\inputs"
    Create-Directory -Path "lib\shared\widgets\cards"
    Create-Directory -Path "lib\shared\widgets\dialogs"
    Create-Directory -Path "lib\shared\services"
    
    # Create platforms directory structure
    Create-Directory -Path "lib\platforms\mobile\android"
    Create-Directory -Path "lib\platforms\mobile\ios"
    Create-Directory -Path "lib\platforms\web"
    Create-Directory -Path "lib\platforms\desktop\windows"
    Create-Directory -Path "lib\platforms\desktop\macos"
    Create-Directory -Path "lib\platforms\desktop\linux"
    
    # Create test directory structure (mirroring lib)
    Create-Directory -Path "test\core"
    Create-Directory -Path "test\features\authentication"
    Create-Directory -Path "test\features\onboarding"
    Create-Directory -Path "test\features\notifications"
    Create-Directory -Path "test\features\analytics"
    Create-Directory -Path "test\features\in_app_purchase"
    Create-Directory -Path "test\shared"
    Create-Directory -Path "test\platforms"
    
    Write-Host "Directory structure created successfully!" -ForegroundColor Cyan
    
    # Return to original location
    Set-Location -Path ".."
}

# Run the main function
Create-ProjectStructure
