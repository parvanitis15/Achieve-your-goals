# README.md

# Quote Generation Project

## Overview
This project leverages GitHub Models to generate an inspiring quote about building new habits. It uses the Flask API to set up an API endpoint to send the quote.

## Project Structure
```
quote-generation-project
├── src
│   ├── main.py
│   ├── api
│   │   └── quote_generator.py
|   |   └── test_quote_generator.py
│   ├── models
│   │   └── quote_model.py
|   |   └── test_quote_model.py
│   └── utils
│       └── helper.py
├── requirements.txt
├── .gitignore
└── README.md
```

## Prerequisites
- Python 3.10 or higher (if you have an older version, e.g. 3.6, you can probably lower the version of the dependencies in the `requirements.txt` file)
- GitHub Personal Access Token (PAT) to access the GitHub API

## Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd quote-generation-project
   ```
3. Set up a virtual environment:
   ```
   python -m venv venv
   ```
4. Activate the virtual environment:
   - On Windows:
     ```
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```
     source venv/bin/activate
     ```
5. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```
6. Set up the Azure AI Inference API:
   - Set the `GITHUB_TOKEN` environment variable to your personal access token:
     ```
     export GITHUB_TOKEN=<your_personal_access_token>
     ```
   - For more information: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

## Usage
To run the application, execute the following command:
```
python src/main.py
```

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for any suggestions or improvements.

## License
This project is licensed under the MIT License.