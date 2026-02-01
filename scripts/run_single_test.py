import subprocess
from pathlib import Path
from datetime import datetime
import csv

# --- CONFIG ---
robot_file = Path("../tests/FuelTickets/ClusterTicket.robot")
results_csv = Path("../results/test_results.csv")  # Path to your CSV file

# --- Extract info ---
test_name = robot_file.stem  # "ClusterTicket"
module_name = robot_file.parent.name  # "FuelTickets"
timestamp = datetime.now().strftime("%Y-%m-%d_%H%M%S")

# --- Report Folder Path ---
report_dir = robot_file.parent / "reports" / test_name / timestamp
report_dir.mkdir(parents=True, exist_ok=True)

# --- Run the Robot Framework Test ---
print(f"\n🚀 Running: {robot_file}")
print(f"📁 Saving report to: {report_dir}")

result = subprocess.run([
    "robot",
    f"--output={report_dir / 'output.xml'}",
    f"--log={report_dir / 'log.html'}",
    f"--report={report_dir / 'report.html'}",
    str(robot_file)
])

# --- Determine Status ---
status = "PASS" if result.returncode == 0 else "FAIL"
print(f"\n📊 Result: {test_name} → {'✅' if status=='PASS' else '❌'}")
print(f"📄 Report saved at: {report_dir}")

# --- Save Result to CSV ---
results_csv.parent.mkdir(parents=True, exist_ok=True)  # Ensure folder exists

# Check if CSV exists, if not add header
file_exists = results_csv.is_file()
with open(results_csv, mode="a", newline="") as f:
    writer = csv.writer(f)
    if not file_exists:
        writer.writerow(["Timestamp", "Module", "TestName", "Status", "ReportPath"])
    writer.writerow([timestamp, module_name, test_name, status, str(report_dir)])

print(f"📝 Results logged in: {results_csv}")
