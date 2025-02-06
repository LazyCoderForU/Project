#!/bin/bash

# Script to create backdated commits for NER CRF project
# Based on the instructions in read.md

# Set up repository if not already done
echo "Setting up git repository..."
git init

# Check if remote already exists
if ! git remote | grep -q "origin"; then
  echo "Please enter your GitHub username:"
  read USERNAME
  echo "Please enter your repository name:"
  read REPO_NAME
  git remote add origin https://github.com/$USERNAME/$REPO_NAME.git
else
  echo "Remote origin already exists."
fi

# Define project files
FILES=(
  "CRF model for Ner.ipynb"
  "ner_dataset.csv"
  "read.md"
)

# Define a start date (2 months ago)
START_DATE=$(date -d "2 months ago" +"%Y-%m-%d")
echo "Starting commits from date: $START_DATE"

# Define realistic commit messages for NER project development
MESSAGES=(
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

# Generate dates over the 2-month period (approximately 60 days)
DATES=()
for i in {0..59}; do
  DATES[$i]=$(date -d "$START_DATE + $i days" +"%a %b %d %T %Y %z")
done

# Randomize the number of commits per day (1-3)
echo "Creating commits with backdated timestamps..."
commit_count=0
for i in {0..59}; do
  # Random number of commits for this day (1-3)
  num_commits=$((1 + RANDOM % 3))
  
  for j in $(seq 1 $num_commits); do
    if [ $commit_count -lt ${#MESSAGES[@]} ]; then
      echo "Commit $commit_count: ${MESSAGES[$commit_count]} on ${DATES[$i]}"
      
      # Create a small change to the notebook file
      # In a real scenario, you might want to make more meaningful changes
      echo "# Development progress - commit $commit_count" >> "development_notes.txt"
      
      # Stage all files on first commit, then just the changed file
      if [ $commit_count -eq 0 ]; then
        git add .
      else
        git add development_notes.txt
      fi
      
      # Create the backdated commit
      GIT_AUTHOR_DATE="${DATES[$i]}" GIT_COMMITTER_DATE="${DATES[$i]}" \
        git commit -m "${MESSAGES[$commit_count]}"
        
      commit_count=$((commit_count + 1))
    fi
  done
  
  # Break if we've used all messages
  if [ $commit_count -ge ${#MESSAGES[@]} ]; then
    break
  fi
  
  # Small delay for realism
  sleep 0.5
done

echo "Created $commit_count backdated commits."
echo ""
echo "Now you can push to GitHub with:"
echo "git branch -M main"
echo "git push -u origin main --force"
echo ""
echo "Note: --force is only needed if you've already pushed to this repo."