import openpyxl
from robot.api.deco import keyword

class ExcelLibrary:
    @keyword("Read Fuel Ticket Data")
    def read_fuel_ticket_data(self, filepath):
        workbook = openpyxl.load_workbook(filepath)
        sheet = workbook.active

        rows = list(sheet.iter_rows(values_only=True))
        if not rows or len(rows) < 2:
            return []

        headers = rows[0]
        data_list = []

        for row in rows[1:]:
            data = {}
            for key, value in zip(headers, row):
                data[key] = value
            data_list.append(data)

        return data_list

ROBOT_LIBRARY_SCOPE = 'GLOBAL'