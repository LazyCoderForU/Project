# PowerShell script for creating backdated commits for GitHub contribution graph

Write-Host "Setting up git repository for backdated commits..." -ForegroundColor Cyan

# Initialize git repository if not already initialized
if (-not (Test-Path ".git")) {
    git init
    Write-Host "Git repository initialized." -ForegroundColor Green
} else {
    Write-Host "Git repository already exists." -ForegroundColor Yellow
}

# Check if remote exists and configure if needed
$remoteExists = git remote -v | Select-String -Pattern "origin" -Quiet
if (-not $remoteExists) {
    $username = Read-Host "Please enter your GitHub username"
    $repoName = Read-Host "Please enter your repository name"
    git remote add origin "https://github.com/$username/$repoName.git"
    Write-Host "Remote 'origin' added." -ForegroundColor Green
} else {
    Write-Host "Remote 'origin' already exists." -ForegroundColor Yellow
}

# Calculate start date (2 months ago)
$startDate = (Get-Date).AddMonths(-2)
Write-Host "Starting commits from: $($startDate.ToString("yyyy-MM-dd"))" -ForegroundColor Cyan

# Create a tracking file for changes
if (-not (Test-Path "development_notes.txt")) {
    "# Project Development History" | Out-File -FilePath "development_notes.txt"
}

# Create array of commit messages
$commitMessages = @(
    "Initial commit: Project setup"
    "Added dataset for named entity recognition"
    "Created basic notebook structure"
    "Imported required libraries for CRF model"
    "Added data loading and preprocessing steps"
    "Fixed encoding issues with the dataset"
    "Implemented sentence class for data preparation"
    "Created feature extraction functions"
    "Added word2features implementation"
    "Completed sentence to features conversion"
    "Split data into training and testing sets"
    "Initialized CRF model with hyperparameters"
    "Added model training code"
    "Implemented prediction functionality"
    "Added evaluation metrics: F1 score"
    "Added precision score calculation"
    "Added sequence accuracy evaluation"
    "Added recall score evaluation"
    "Added flat accuracy evaluation"
    "Generated classification report visualization"
    "Added test sentence for NER demonstration"
    "Integrated NLTK for POS tagging"
    "Added predicted tag visualization"
    "Fixed bug in feature extraction"
    "Enhanced tokenization for better accuracy"
    "Improved feature set for better entity recognition"
    "Added SpaCy visualization for named entities"
    "Enhanced model with better context features"
    "Added dependency visualization with SpaCy"
    "Optimized parameters for better performance"
    "Added documentation for feature extraction"
    "Updated README with project description"
    "Fine-tuned model hyperparameters"
    "Added more contextual features"
    "Fixed issue with boundary entity detection"
    "Enhanced visualization of entities"
    "Added error analysis for misclassified entities"
    "Improved feature extraction for edge cases"
    "Added support for custom entity types"
    "Enhanced model with BIO tagging scheme"
    "Added cross-validation for model evaluation"
    "Refactored code for better readability"
    "Fixed data loading issue"
    "Added comparison with baseline model"
    "Enhanced documentation with examples"
    "Implemented better context window features"
    "Added support for numerical entities"
    "Fixed boundary detection for complex entities"
    "Added custom evaluation metrics"
    "Improved visualization for entity relations"
    "Added detection for nested entities"
    "Enhanced model for better organization detection"
    "Fixed issues with person entity recognition"
    "Added geopolitical entity recognition improvements"
    "Enhanced time entity detection"
    "Added better artifact entity detection"
    "Final model optimization"
    "Project completion and documentation update"
    "Added performance benchmarks"
    "Final code cleanup and optimization"
)

# First commit - add all files
Write-Host "Creating initial commit..." -ForegroundColor Cyan
git add .
$env:GIT_AUTHOR_DATE = $startDate.ToString("ddd MMM d HH:mm:ss yyyy +0000")
$env:GIT_COMMITTER_DATE = $startDate.ToString("ddd MMM d HH:mm:ss yyyy +0000")
git commit -m $commitMessages[0]
Write-Host "Initial commit created with date: $($env:GIT_AUTHOR_DATE)" -ForegroundColor Green

# Generate commits over 60 days
Write-Host "Creating backdated commits..." -ForegroundColor Cyan
$commitCount = 1  # Start at 1 since we already did the initial commit

# Create a date array for 60 days
$dates = @()
for ($i = 0; $i -lt 60; $i++) {
    $dates += $startDate.AddDays($i).ToString("ddd MMM d HH:mm:ss yyyy +0000")
}

# Create commits with backdated timestamps
for ($day = 1; $day -lt 60; $day++) {
    # Random number of commits for this day (1-3)
    $numCommits = Get-Random -Minimum 1 -Maximum 4
    
    for ($j = 0; $j -lt $numCommits; $j++) {
        if ($commitCount -lt $commitMessages.Count) {
            $commitDate = $startDate.AddDays($day)
            $dateString = $commitDate.ToString("ddd MMM d HH:mm:ss yyyy +0000")
            
            # Create a change
            "# Development progress - commit $commitCount - $($commitDate.ToString('yyyy-MM-dd'))" | Out-File -FilePath "development_notes.txt" -Append
            
            # Commit with backdated timestamp
            Write-Host "Commit $commitCount`: $($commitMessages[$commitCount]) on $($commitDate.ToString('yyyy-MM-dd'))" -ForegroundColor Cyan
            git add development_notes.txt
            $env:GIT_AUTHOR_DATE = $dateString
            $env:GIT_COMMITTER_DATE = $dateString
            git commit -m $commitMessages[$commitCount]
            
            $commitCount++
        }
    }
    
    # Break if we've used all messages
    if ($commitCount -ge $commitMessages.Count) {
        break
    }
    
    # Small delay for realism
    Start-Sleep -Milliseconds 100
}

Write-Host "`nCreated $commitCount backdated commits over a 2-month period." -ForegroundColor Green
Write-Host "`nNow you can push to GitHub with:"
Write-Host "git branch -M main" -ForegroundColor Yellow
Write-Host "git push -u origin main --force" -ForegroundColor Yellow
Write-Host "`nNote: --force is only needed if you've already pushed to this repo." -ForegroundColor Red

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")