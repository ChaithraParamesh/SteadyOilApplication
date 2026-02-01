import os
import sys
import time
import subprocess
import shutil
import xml.etree.ElementTree as ET
import csv

# ---------------- CONFIG ----------------
PROJECT_ROOT = r"C:\Users\Chaithra\PycharmProjects\SteadyOilApplicationProject"
REPORTS_ROOT = os.path.join(PROJECT_ROOT, "reports")
RESULTS_ROOT = os.path.join(PROJECT_ROOT, "results")
SCREENSHOTS_ROOT = os.path.join(PROJECT_ROOT, "screenshots")
ONEDRIVE_ROOT = r"C:\Users\Chaithra\OneDrive - Coddle Technologies\Steady Oil Automation\Robot reports"

# ---------------- STEP 1: Get .robot file and optional test case ----------------
if len(sys.argv) < 2:
    print("❌ Usage: python run_with_reports.py <path_to_robot_file> [<test_case_name>]")
    sys.exit(1)

robot_file = sys.argv[1]
test_case_name = sys.argv[2] if len(sys.argv) > 2 else None  # optional

if not os.path.isfile(robot_file):
    print(f"❌ File not found: {robot_file}")
    sys.exit(1)

# ---------------- STEP 2: Extract info ----------------
test_name = os.path.splitext(os.path.basename(robot_file))[0]
module_name = os.path.basename(os.path.dirname(robot_file))
timestamp = time.strftime("%Y-%m-%d_%H%M%S")

# ---------------- STEP 3: Create local folders ----------------
report_dir = os.path.join(REPORTS_ROOT, module_name, test_name, timestamp)
os.makedirs(report_dir, exist_ok=True)
os.makedirs(SCREENSHOTS_ROOT, exist_ok=True)
os.makedirs(RESULTS_ROOT, exist_ok=True)

# ---------------- STEP 4: Run Robot Framework ----------------
output_xml_path = os.path.join(report_dir, "output.xml")
command = [
    "robot",
    f"--outputdir={report_dir}",
    f"--output={output_xml_path}",
    f"--reporttitle={module_name} - {test_name} ({timestamp})",
    f"--logtitle=Execution Log - {test_name}",
]

# Add specific test case if provided
if test_case_name:
    command.append(f"--test={test_case_name}")

command.append(robot_file)

print(f"🚀 Running: {' '.join(command)}")
result = subprocess.run(command, capture_output=True, text=True)

# ---------------- STEP 5: Print console summary ----------------
for line in result.stdout.splitlines():
    if "PASS" in line or "FAIL" in line:
        print(line)

print(f"\n✅ Local report generated at: {report_dir}")

# ---------------- STEP 6: Collect failed screenshots ----------------
failed_screenshots = []
if os.path.exists(output_xml_path):
    tree = ET.parse(output_xml_path)
    root_xml = tree.getroot()

    for msg in root_xml.findall(".//msg[@level='FAIL']"):
        if msg.text and msg.text.endswith(".png"):
            screenshot_name = os.path.basename(msg.text.strip())
            screenshot_path = os.path.join(SCREENSHOTS_ROOT, screenshot_name)
            if os.path.exists(screenshot_path):
                failed_screenshots.append(screenshot_path)

# ---------------- STEP 7: Parse output.xml for metrics ----------------
total = passed = failed = 0
duration = 0

if os.path.exists(output_xml_path):
    for test in root_xml.findall(".//test"):
        total += 1
        status = test.find("status").attrib.get("status", "")
        if status == "PASS":
            passed += 1
        elif status == "FAIL":
            failed += 1

    duration = root_xml.find(".//suite/status").attrib.get("elapsed", "0")
    print(f"\n📊 Test Metrics → Total: {total}, Passed: {passed}, Failed: {failed}, Duration: {duration} sec")
else:
    print("⚠️ output.xml not found, skipping metrics parsing.")

# ---------------- STEP 8: Save metrics to CSV ----------------
csv_file = os.path.join(RESULTS_ROOT, "Test_Summary.csv")
file_exists = os.path.isfile(csv_file)

with open(csv_file, mode="a", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    if not file_exists:
        writer.writerow(["Timestamp", "Module", "Test File", "Total", "Passed", "Failed",
                         "Duration(sec)", "Report Path", "Failed Screenshots"])
    writer.writerow([timestamp, module_name, test_name, total, passed, failed, duration,
                     report_dir, ";".join(failed_screenshots) if failed_screenshots else "None"])

print(f"📑 Metrics logged in: {csv_file}")

# ---------------- STEP 9: Upload reports + failed screenshots to OneDrive ----------------
onedrive_base = os.path.join(ONEDRIVE_ROOT, module_name, test_name, timestamp)
onedrive_reports = os.path.join(onedrive_base, "Reports")
onedrive_screenshots = os.path.join(onedrive_base, "Failed_Screenshots")

# Copy reports
shutil.copytree(report_dir, onedrive_reports)

# Copy only failed screenshots
if failed_screenshots:
    os.makedirs(onedrive_screenshots, exist_ok=True)
    for file in failed_screenshots:
        shutil.copy(file, onedrive_screenshots)

print(f"📤 Reports uploaded to OneDrive at: {onedrive_reports}")
if failed_screenshots:
    print(f"📤 Failed screenshots uploaded to OneDrive at: {onedrive_screenshots}")
else:
    print("✅ No failed screenshots to upload.")

print("🔧 Final Robot command:", " ".join(command))
