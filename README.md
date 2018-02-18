# iQuiz

## Assignment
This is a multiple-choice Q&A application. Users can choose from a selection of quizzes, that each have a set number of questions. Each question has a multiple-choice answer, and users progress through questions one at a time, tracking their scores.

When a user selects a quiz, they go through question and answer screens; once there are no more questions, the user is taken to the finish screen where they will know how well they did on the quiz. From there, the user is taken back to the main screen to continue taking quizzes.

The quizzes come from online, through a JSON file. After data is downloaded, it's stored to local storage; if the user is unable to access an online source or has there's no network connection, the user will be notified and data will be loaded locally if possible.

If the user decides they want to access different quizzes, they can enter a new URL by hitting the settings button to download new data, but then has to pull down to refresh the table.

## Extra Credit
If at any point a user decides to abandon the quiz, swiping left will take them back to the initial screen. Swiping right also takes the user to the next screen (when progressing is available).

Pulling down on the TableView will refresh the cells

External JSON: https://ktran29.github.io/jsonHost/quiz.json
