from calendar import Calendar
from datetime import date

WEEK_DAYS = ['Monday', 'Tuesday', 'Wednesday',
             'Thursday', 'Friday', 'Saturday', 'Sunday', ]


def meetup(year, month, week, day_of_week):
    days = [(d, w) for d, w in Calendar().itermonthdays2(year, month)
            if d != 0 and WEEK_DAYS[w] == day_of_week]

    if week == 'teenth':
        day = next(d for d, _ in days if 13 <= d <= 19)
    elif week == 'last':
        day = days[-1][0]
    else:
        try:
            day = days[int(week[0]) - 1][0]
        except IndexError:
            raise MeetupDayException(r".+")

    return date(year, month, day)


class MeetupDayException(Exception):
    pass
