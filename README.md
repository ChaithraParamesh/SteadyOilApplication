# 🛠️ SteadyOil Application Automation Project

## 📌 Overview
This project automates the testing of the **SteadyOil Web Application** using **Robot Framework** with **Selenium** and supporting Python libraries.

The framework supports:
- Automated functional testing across modules (Fuel, Wells, Rigs, Reservations, LNG, Propane, Oil).
- Screenshots captured on failure and saved in the `screenshots/` folder.
- HTML/XML reports stored in `reports/`.
- Excel/CSV results generated in `results/`.

---

## 📂 Folder Structure
SteadyOilApplicationProject/
│── libraries/ # Custom Python libraries
│── reports/ # Execution reports (HTML/XML)
│── resources/ # Shared Robot Framework resources
│── results/ # CSV/Excel results
│── screenshots/ # Captured screenshots
│── scripts/ # Python helper scripts (run tests, reports, etc.)
│── testdata/ # Test data (Excel/CSV)
│── tests/ # Robot Framework test suites
│── requirements.txt # Python dependencies
│── README.md # Project documentation
│── .gitignore # Ignored files for Git


---

## 🚀 Setup Instructions

### 1. Clone the Project
```bash
git clone https://github.com/your-username/SteadyOilApplicationProject.git
cd SteadyOilApplicationProject
```

### 2. Create a virtual environment (recommended):
python -m venv .venv
source .venv/bin/activate   # Linux/Mac
.venv\Scripts\activate      # Windows

### 3. Install dependencies:

pip install -r requirements.txt

## ▶️ Running Tests

### Run all tests
robot Tests/

### Run a specific suite
robot Tests/FuelTickets/SingleTicket.robot

### Run a test and save reports with a timestamp:
python scripts/run_with_reports.py

## 📊 Reports & Results

### Execution Reports
After every run, Robot Framework generates:
- `report.html`
- `log.html`
- `output.xml`

These are stored under:

`reports/<Module>/<TestName>/<timestamp>/`

### CSV/Excel Summaries
A consolidated summary of test runs (timestamp, suite name, total, pass/fail counts, status) is stored in:

results/test_results.csv

or in Excel format (`.xlsx`) if enabled.

## 📷 Screenshots
All failure screenshots are automatically saved under:

screenshots/

## 💡 Notes

To add a new dependency in the future:

```bash
pip install <package-name>
pip freeze > requirements.txt 
```