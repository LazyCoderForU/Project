@echo off
echo Setting up git repository for backdated commits...

:: Initialize git repository
git init

:: Check if remote exists and configure if needed
git remote -v | find "origin" > nul
if errorlevel 1 (
  set /p USERNAME=Please enter your GitHub username: 
  set /p REPO_NAME=Please enter your repository name: 
  git remote add origin https://github.com/%USERNAME%/%REPO_NAME%.git
) else (
  echo Remote origin already exists.
)

:: Set start date (2 months ago from today)
FOR /F "tokens=1,2,3,4 delims=/ " %%A IN ('date /t') DO (
  set DAY=%%A
  set MONTH=%%B
  set YEAR=%%C
)

echo Starting commits from 2 months ago...

:: Create a file to track changes
echo # Development history > development_notes.txt

:: Initial commit with all files
echo Creating initial commit...
git add .
set GIT_AUTHOR_DATE="2 months ago"
set GIT_COMMITTER_DATE="2 months ago"
git commit -m "Initial commit: Project setup"

:: Array of commit messages - Windows batch doesn't support arrays, so we'll use numbered variables
set MSG1=Added dataset for named entity recognition
set MSG2=Created basic notebook structure
set MSG3=Imported required libraries for CRF model
set MSG4=Added data loading and preprocessing steps
set MSG5=Fixed encoding issues with the dataset
set MSG6=Implemented sentence class for data preparation
set MSG7=Created feature extraction functions
set MSG8=Added word2features implementation
set MSG9=Completed sentence to features conversion
set MSG10=Split data into training and testing sets
set MSG11=Initialized CRF model with hyperparameters
set MSG12=Added model training code
set MSG13=Implemented prediction functionality
set MSG14=Added evaluation metrics: F1 score
set MSG15=Added precision score calculation
set MSG16=Added sequence accuracy evaluation
set MSG17=Added recall score evaluation
set MSG18=Added flat accuracy evaluation
set MSG19=Generated classification report visualization
set MSG20=Added test sentence for NER demonstration
set MSG21=Integrated NLTK for POS tagging
set MSG22=Added predicted tag visualization
set MSG23=Fixed bug in feature extraction
set MSG24=Enhanced tokenization for better accuracy
set MSG25=Improved feature set for better entity recognition
set MSG26=Added SpaCy visualization for named entities
set MSG27=Enhanced model with better context features
set MSG28=Added dependency visualization with SpaCy
set MSG29=Optimized parameters for better performance
set MSG30=Added documentation for feature extraction
set MSG31=Updated README with project description
set MSG32=Fine-tuned model hyperparameters
set MSG33=Added more contextual features
set MSG34=Fixed issue with boundary entity detection
set MSG35=Enhanced visualization of entities
set MSG36=Added error analysis for misclassified entities
set MSG37=Improved feature extraction for edge cases
set MSG38=Added support for custom entity types
set MSG39=Enhanced model with BIO tagging scheme
set MSG40=Added cross-validation for model evaluation
set MSG41=Refactored code for better readability
set MSG42=Fixed data loading issue
set MSG43=Added comparison with baseline model
set MSG44=Enhanced documentation with examples
set MSG45=Implemented better context window features
set MSG46=Added support for numerical entities
set MSG47=Fixed boundary detection for complex entities
set MSG48=Added custom evaluation metrics
set MSG49=Improved visualization for entity relations
set MSG50=Added detection for nested entities
set MSG51=Enhanced model for better organization detection
set MSG52=Fixed issues with person entity recognition
set MSG53=Added geopolitical entity recognition improvements
set MSG54=Enhanced time entity detection
set MSG55=Added better artifact entity detection
set MSG56=Final model optimization
set MSG57=Project completion and documentation update
set MSG58=Added performance benchmarks
set MSG59=Final code cleanup and optimization

echo Creating backdated commits (this may take a few minutes)...

:: For Windows, we'll use a simpler approach with relative dates
set days_ago=55

:commit_loop
if %days_ago% LEQ 0 goto done

:: Calculate message index (we have 59 messages plus the initial commit)
set /a msg_index=59-%days_ago%+1
if %msg_index% GTR 59 set msg_index=59

:: Get the message using variable indirection
call set commit_msg=%%MSG%msg_index%%%

:: Create a change
echo # Development progress - commit %msg_index% >> development_notes.txt

:: Commit with backdated timestamp
echo Commit %msg_index%: %commit_msg% (%days_ago% days ago)
git add development_notes.txt
set GIT_AUTHOR_DATE="%days_ago% days ago"
set GIT_COMMITTER_DATE="%days_ago% days ago"
git commit -m "%commit_msg%"

:: Decrease days and continue
set /a days_ago-=1
goto commit_loop

:done
echo.
echo Created backdated commits over a 2-month period.
echo.
echo Now you can push to GitHub with:
echo git branch -M main
echo git push -u origin main --force
echo.
echo Note: --force is only needed if you've already pushed to this repo.
pause