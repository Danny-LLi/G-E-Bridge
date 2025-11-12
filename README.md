---

# 🌉 G E Bridge

**Your personal, self-hosted dashboard for mastering German and English vocabulary.**

G E Bridge connects a sleek, modern web interface directly to a powerful **n8n backend**, using **Google Sheets** as your personal vocabulary database. It's designed to make your language learning fast, organized, and effective.

---

## 🚀 2-Minute Demo

See G E Bridge in action\! This video covers the major features.



https://github.com/user-attachments/assets/bc90f311-2f94-4956-8106-4f4cc732f88b


---

## ✨ Key Features

- **Sleek, Modern UI:** A beautiful, responsive, single-page application (SPA) with a dark mode interface.
- **Dual Language Submission:** Quickly submit new words for both **English** and **German**.
- **Level-Based Learning:** Classify every word in your vocabulary:
  - **Level 1:** Don't Know
  - **Level 2:** Learning
  - **Level 3:** Know Well
  - **Level 4:** Mastered
- **Statistics Dashboard:** Get an instant overview of your progress with stats on:
  - Total words submitted
  - Pending words
  - Modified items
  - A full breakdown by learning level for _both_ languages.
- **Fetch & Filter:** Load your entire vocabulary from Google Sheets and filter your lists by learning level.
- **Save & Delete:** All your changes (level updates, deletions) are saved back to your Google Sheets via n8n.
- **Self-Hosted & Private:** Your data lives in your Google Sheets and your n8n instance. No third-party services.

---

## ⚙️ How It Works

This project has three main components:

1.  **Frontend (`index.html`):** A single, static HTML file that contains all the necessary JavaScript and CSS. It provides the user interface you interact with.
2.  **Backend (`G E Bridge (n8n workflow).json`):** The "brain" of the operation. This n8n workflow listens for requests from the frontend and handles all the logic:
    - `fetch_vocabulary`: Gets all rows from your Google Sheets.
    - `word_submission`: Appends new words to your sheets and even uses a `GOOGLETRANSLATE` formula to add a translation.
    - `vocabulary_update`: Updates word levels or deletes rows in your sheets.
3.  **Launcher (`start_bridge.sh`):** A simple shell script that starts a local Python web server to serve the `index.html` file and opens it in your browser.

---

## 🏁 Getting Started

### Prerequisites

- An active **n8n** instance (self-hosted or cloud).
- A **Google Sheets** account with two separate sheets (e.g., "German words" and "English words").
- Google Cloud project set up with the Sheets API enabled and **OAuth credentials** for n8n.
- **Python 3** installed (to run the local web server).

### 1\. Backend Setup (n8n)

1.  **Import Workflow:** Import the `G E Bridge (n8n workflow).json` file into your n8n instance.
2.  **Configure Credentials:** Configure all the `Google Sheets` nodes. You will need to create and connect your own Google Sheets OAuth credentials.
3.  **Link Your Sheets:** Update the **Document ID** and **Sheet Name** in all Google Sheets nodes to point to _your_ two sheets.
    > **Note:** The workflow expects specific column names (like `English word`, `German word`, `Level`). Ensure your sheets have these columns.
4.  **Activate Workflow:** Save and activate the workflow.
5.  **Copy Webhook URL:** From the `Webhook` node, copy the **POST** URL. This is the bridge to your frontend.

### 2\. Frontend Setup

1.  **Download Files:** Place `index.html` and `start_bridge.sh` in a project directory (e.g., `/usr/bin/mine/G_E_Bridge` as used in the script).
2.  **Make Executable:** Give the launcher script permission to run:
    ```bash
    chmod +x start_bridge.sh
    ```
3.  **Run the App:** Execute the script:
    ```bash
    ./start_bridge.sh
    ```
    This will start a local server on **port 26524** and automatically open `http://localhost:26524` in your default browser.
4.  **Connect to n8n:** In the app's UI, paste the **n8n Webhook URL** you copied in step 5 into the "Webhook Configuration" field. The URL is saved automatically in your browser's local storage.

You are now ready to start adding and managing your vocabulary\!

---

## 📖 How to Use

1.  **Add Words:** Type a word (or multiple words on new lines) into the "Submit New Words" box, select **EN** or **DE**, and click "Add to List."
2.  **Submit Words:** When you've added all your words, click "Submit All Words" to send them to your Google Sheets.
3.  **Fetch Vocabulary:** Click "Fetch Vocabulary from n8n" to load all your existing words into the two lists.
4.  **Update Levels:** As you study, update a word's status by clicking the level buttons (1-4). The row will be marked with a yellow indicator.
5.  **Save Changes:** When you're done making changes, click "Save All Changes" to push all your level updates and deletions back to Google Sheets.
