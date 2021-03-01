# -*- coding: utf-8 -*-


def create_entry(date, description, change):
    return (list(map(int, date.split("-"))), description, change)


def format_entries(currency, locale, entries):
    if currency == "USD":
        symbol = "$"
    elif currency == "EUR":
        symbol = u"€"

    if locale == "en_US":
        header = ("Date", "Description", "Change")
        date_fmt = "{1:02}/{2:02}/{0}"
        number_po_fmt = "{}{} "
        number_ne_fmt = "({}{})"
        thousands = ","
        decimal = "."
    elif locale == "nl_NL":
        header = ("Datum", "Omschrijving", "Verandering")
        date_fmt = "{2:02}-{1:02}-{0}"
        number_po_fmt = "{} {} "
        number_ne_fmt = "{} -{} "
        thousands = "."
        decimal = ","

    ret = ["{:<11}| {:<26}| {:<13}".format(*header)]

    for date, description, change in sorted(entries):
        date = date_fmt.format(*date)
        if len(description) > 25:
            description = description[:22] + "... "
        change_abs = "{:.2f}".format(abs(change) / 100).replace(".", decimal)
        for i in range(len(change_abs) - 6, 0, -3):
            change_abs = change_abs[:i] + thousands + change_abs[i:]
        number_fmt = number_ne_fmt if change < 0 else number_po_fmt
        change = number_fmt.format(symbol, change_abs)

        ret.append("{:<11}| {:<26}| {:>13}".format(date, description, change))

    return "\n".join(ret)
