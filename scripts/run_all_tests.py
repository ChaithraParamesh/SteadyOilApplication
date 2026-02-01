import os
import subprocess
from pathlib import Path
from datetime import datetime
import pandas as pd

# Base project directory (root)
BASE_DIR = Path(__file__).resolve().parent

# Timestamp for report folders
timestamp = datetime.now().strftime("%Y-%m-%d_%H%M%S")

# Collect results
summary_data = []

# Loop through all .robot files
for robot_file in BASE_DIR.rglob("*.robot"):
    if "venv" in robot_file.parts:
        continue

    test_name = robot_file.stem
    module_name = robot_file.parent.name

    # Folder: <module>/reports/<test_name>/<timestamp>/
    report_dir = BASE_DIR / module_name / "reports" / test_name / timestamp
    report_dir.mkdir(parents=True, exist_ok=True)

    print(f"\n🔹 Running: {test_name} in {module_name}")
    print(f"🔸 Saving reports to: {report_dir}")

    # Run the Robot Framework test
    result = subprocess.run([
        "robot",
        f"--output={report_dir / 'output.xml'}",
        f"--log={report_dir / 'log.html'}",
        f"--report={report_dir / 'report.html'}",
        str(robot_file)
    ])

    status = "PASS" if result.returncode == 0 else "FAIL"

    summary_data.append({
        "Module": module_name,
        "TestCase": test_name,
        "Status": status,
        "Report Path": str(report_dir)
    })

# Print Summary in Console
print("\n📊 Execution Summary:")
for row in summary_data:
    print(f"{row['Module']}/{row['TestCase']} → ✅ {row['Status']}")

# Export to CSV and Excel
summary_df = pd.DataFrame(summary_data)

# Save in root reports folder
export_base = BASE_DIR / "ExecutionReports"
export_base.mkdir(parents=True, exist_ok=True)

csv_file = export_base / f"TestSummary_{timestamp}.csv"
excel_file = export_base / f"TestSummary_{timestamp}.xlsx"

summary_df.to_csv(csv_file, index=False)
summary_df.to_excel(excel_file, index=False)

print(f"\n✅ Summary CSV: {csv_file}")
print(f"✅ Summary Excel: {excel_file}")
